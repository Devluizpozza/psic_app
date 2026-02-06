import 'package:get/get.dart';
import 'package:psicApp/app/modules/login/select_role_controller.dart';

class SelectRoleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectRoleController>(() => SelectRoleController());
  }
}
