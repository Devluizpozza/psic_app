import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/core/logger/logger.dart';
import 'package:psicApp/app/data/repositories/time_slot_repository.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';
import 'package:psicApp/app/presentation/shared/handlers/snack_bar_handler.dart';
import 'package:uuid/uuid.dart';

class ScheduleOwnerListController extends GetxController {
  final TimeSlotRepository _repo;

  ScheduleOwnerListController({TimeSlotRepository? repo})
      : _repo = repo ?? TimeSlotRepository();

  // Lista principal exibida na tela (DB + adições pendentes - remoções pendentes)
  final RxList<TimeSlot> timeSlots = <TimeSlot>[].obs;

  // Pendências locais — só vão ao Firestore quando salvar
  final _pendingAdds = <TimeSlot>[];
  final _pendingDeletes = <String>[];

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  static const int _firstHour = 8;
  static const int _lastHour = 18;

  List<int> get availableHours =>
      List.generate(_lastHour - _firstHour, (i) => i + _firstHour);

  String get psychologistId => UserController.instance.user!.uid;

  bool get hasPendingChanges =>
      _pendingAdds.isNotEmpty || _pendingDeletes.isNotEmpty;

  @override
  void onInit() {
    fetchTimeSlots();
    super.onInit();
  }

  Future<void> fetchTimeSlots() async {
    isLoading.value = true;
    try {
      timeSlots.value = await _repo.listByPsychologistId(psychologistId);
      _pendingAdds.clear();
      _pendingDeletes.clear();
    } catch (e) {
      Logger.info(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  // Adiciona apenas localmente — sem chamar o banco
  void addTimeSlot(int hour) {
    final start = DateTime(
      selectedDate.value.year,
      selectedDate.value.month,
      selectedDate.value.day,
      hour,
    );
    final end = start.add(const Duration(hours: 1));

    final alreadyExists = timeSlots.any(
      (ts) =>
          ts.startAt.year == start.year &&
          ts.startAt.month == start.month &&
          ts.startAt.day == start.day &&
          ts.startAt.hour == start.hour,
    );

    if (alreadyExists) {
      SnackBarHandler.snackBarError('Horário já adicionado para este dia.');
      return;
    }

    final slot = TimeSlot(
      uid: const Uuid().v4(),
      psychologistId: psychologistId,
      startAt: start,
      endAt: end,
      isAvailable: true,
      patientId: null,
    );

    _pendingAdds.add(slot);
    timeSlots.add(slot);
    timeSlots.sort((a, b) => a.startAt.compareTo(b.startAt));
    timeSlots.refresh();
  }

  // Remove apenas localmente — sem chamar o banco
  void removeTimeSlot(TimeSlot slot) {
    if (!slot.isAvailable) {
      SnackBarHandler.snackBarError(
        'Não é possível remover um horário já agendado.',
      );
      return;
    }

    // Se estava só na fila de adição, basta remover dali
    final wasOnlyPending = _pendingAdds.remove(slot);

    // Se já existia no banco, precisa deletar lá também
    if (!wasOnlyPending) {
      _pendingDeletes.add(slot.uid);
    }

    timeSlots.remove(slot);
    timeSlots.refresh();
  }

  // Persiste todas as alterações pendentes no Firestore de uma vez
  Future<void> saveChanges() async {
    if (!hasPendingChanges) return;

    isSaving.value = true;
    try {
      final createResults = await Future.wait(
        _pendingAdds.map((slot) => _repo.create(psychologistId, slot)),
      );
      final deleteResults = await Future.wait(
        _pendingDeletes.map((uid) => _repo.delete(psychologistId, uid)),
      );

      final allSucceeded =
          createResults.every((r) => r) && deleteResults.every((r) => r);

      if (allSucceeded) {
        _pendingAdds.clear();
        _pendingDeletes.clear();
        SnackBarHandler.snackBarSuccess('Horários salvos com sucesso!');
      } else {
        SnackBarHandler.snackBarError('Alguns horários não puderam ser salvos.');
      }
    } catch (e) {
      Logger.info(e.toString());
      SnackBarHandler.snackBarError('Erro ao salvar horários.');
    } finally {
      isSaving.value = false;
    }
  }

  List<TimeSlot> get timeSlotsForSelectedDate {
    final d = selectedDate.value;
    return timeSlots.where((ts) {
      return ts.startAt.year == d.year &&
          ts.startAt.month == d.month &&
          ts.startAt.day == d.day;
    }).toList();
  }

  bool isHourAdded(int hour) =>
      timeSlotsForSelectedDate.any((ts) => ts.startAt.hour == hour);
}
