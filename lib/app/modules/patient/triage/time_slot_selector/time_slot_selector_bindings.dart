import 'package:get/get.dart';
import 'package:psicApp/app/modules/patient/triage/time_slot_selector/time_slot_selector_controller.dart';

class TimeSlotSelectorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeSlotSelectorController>(() => TimeSlotSelectorController());
  }
}
