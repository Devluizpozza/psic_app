import 'package:get/get.dart';
import 'package:psicApp/app/modules/patient/triage/psy_selector/psychologist_selector_controller.dart';

class PsychologistSelectorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsychologistSelectorController>(
      () => PsychologistSelectorController(),
    );
  }
}
