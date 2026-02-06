import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:psicApp/app/models/time_slot_model.dart';

class AgendaController extends GetxController {
  final Rx<DateTime> _selectedDay = DateTime.now().obs;
  final RxBool _isLoading = false.obs;
  final RxList<DateTime> _slots = <DateTime>[].obs;
  final Rx<List<DateTime>> _availableDays = Rx<List<DateTime>>([]);

  late final String psychologistId;

  DateTime get selectedDay => _selectedDay.value;
  bool get isLoading => _isLoading.value;

  List<DateTime> get slots => _slots;

  List<DateTime> get availableDays => _availableDays.value;

  set availableDays(List<DateTime> value) {
    _availableDays.value = value;
    _availableDays.refresh();
  }

  void selectDay(DateTime day) {
    _selectedDay.value = day;
    // loadSlots();
  }

  void setLoading(bool value) {
    _isLoading.value = value;
  }

  void setSlots(List<DateTime> value) {
    _slots.assignAll(value);
  }

  /// ============================
  /// BUSINESS LOGIC
  /// ============================

  // Future<void> loadSlots() async {
  //   try {
  //     setLoading(true);

  //     final result = await getAvailableSlotsUseCase(
  //       psychologistId,
  //       _selectedDay.value,
  //     );

  //     setSlots(result);
  //   } catch (e) {
  //     Get.snackbar('Erro', 'Não foi possível carregar os horários');
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  // Future<void> bookSlot(String slotId) async {
  //   try {
  //     setLoading(true);

  //     await bookSlotUseCase(slotId, Get.find<AuthController>().user.id);

  //     await loadSlots(); // Recarrega após reserva
  //   } catch (e) {
  //     Get.snackbar('Erro', 'Não foi possível reservar o horário');
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  /// ============================
  /// LIFECYCLE
  /// ============================
  ///
  void viewDay(DateTime selectedDay) {
    print(selectedDay);
  }

  void updateAvailableDays(List<TimeSlot> slots) {
    final days =
        slots
            .where((slot) => slot.isAvailable)
            .map((slot) => DateUtils.dateOnly(slot.startAt))
            .toSet();

    availableDays = [...(days)];
  }
}
