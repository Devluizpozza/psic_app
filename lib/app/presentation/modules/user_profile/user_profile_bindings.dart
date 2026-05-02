import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/user_profile/user_profile_controller.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
