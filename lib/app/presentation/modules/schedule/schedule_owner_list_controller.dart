import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/core/logger/logger.dart';
import 'package:psicApp/app/data/repositories/time_slot_repository.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';
import 'package:psicApp/app/presentation/shared/handlers/snack_bar_handler.dart';
import 'package:uuid/uuid.dart';

class ScheduleOwnerListController extends GetxController {
  final TimeSlotRepository _repo = TimeSlotRepository();

  final RxList<TimeSlot> timeSlots = <TimeSlot>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxBool isLoading = false.obs;

  static const int _firstHour = 8;
  static const int _lastHour = 18;

  List<int> get availableHours =>
      List.generate(_lastHour - _firstHour, (i) => i + _firstHour);

  String get psychologistId => UserController.instance.user!.uid;

  @override
  void onInit() {
    fetchTimeSlots();
    super.onInit();
  }

  Future<void> fetchTimeSlots() async {
    isLoading.value = true;
    try {
      timeSlots.value = await _repo.listByPsychologistId(psychologistId);
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

  Future<void> addTimeSlot(int hour) async {
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

    final success = await _repo.create(psychologistId, slot);
    if (success) {
      timeSlots.add(slot);
      timeSlots.sort((a, b) => a.startAt.compareTo(b.startAt));
    } else {
      SnackBarHandler.snackBarError('Erro ao criar horário.');
    }
  }

  Future<void> removeTimeSlot(TimeSlot slot) async {
    if (!slot.isAvailable) {
      SnackBarHandler.snackBarError(
        'Não é possível remover um horário já agendado.',
      );
      return;
    }

    final success = await _repo.delete(psychologistId, slot.uid);
    if (success) {
      timeSlots.remove(slot);
    } else {
      SnackBarHandler.snackBarError('Erro ao remover horário.');
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
