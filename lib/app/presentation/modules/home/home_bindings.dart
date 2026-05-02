import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
