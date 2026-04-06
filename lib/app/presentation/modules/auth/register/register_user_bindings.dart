import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/auth/register/register_user_controller.dart';

class RegisterUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterUserController>(() => RegisterUserController());
  }
}
