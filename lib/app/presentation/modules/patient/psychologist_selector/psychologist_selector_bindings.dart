import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/patient/psychologist_selector/psychologist_selector_controller.dart';

class PsychologistSelectorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsychologistSelectorController>(
      () => PsychologistSelectorController(),
    );
  }
}
