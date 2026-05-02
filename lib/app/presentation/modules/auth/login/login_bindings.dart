import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/auth/login/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
