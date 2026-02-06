import 'package:get/get.dart';
import 'package:psicApp/app/modules/login/register_user_controller.dart';

class RegisterUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterUserController>(() => RegisterUserController());
  }
}
