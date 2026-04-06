import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/auth/sms/confirm_sms_code_controller.dart';

class ConfirmSmsCodeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmSmsCodeController>(() => ConfirmSmsCodeController());
  }
}
