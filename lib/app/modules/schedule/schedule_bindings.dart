import 'package:estacionaqui/app/modules/schedule/schedule_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());
  }
}
