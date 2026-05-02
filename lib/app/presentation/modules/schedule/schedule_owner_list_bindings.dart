import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/schedule/schedule_owner_list_controller.dart';

class ScheduleOwnerListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleOwnerListController>(
      () => ScheduleOwnerListController(),
    );
  }
}
