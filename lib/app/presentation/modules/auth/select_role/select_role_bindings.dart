import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/auth/select_role/select_role_controller.dart';

class SelectRoleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectRoleController>(() => SelectRoleController());
  }
}
