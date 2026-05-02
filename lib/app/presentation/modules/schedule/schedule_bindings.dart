import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/schedule/schedule_controller.dart';

class ScheduleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());
  }
}
