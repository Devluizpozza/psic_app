import 'package:get/get.dart';
import 'package:psicApp/app/modules/patient/triage/patrient_triage_controller.dart';

class PatientTriageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTriageController>(() => PatientTriageController());
  }
}
