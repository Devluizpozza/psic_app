import 'package:get/get.dart';
import 'package:psicApp/app/modules/schedule/schedule_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());
  }
}
