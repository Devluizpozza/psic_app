import 'package:estacionaqui/app/modules/patient/triage/patrient_triage_controller.dart';
import 'package:get/get.dart';

class PatientTriageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTriageController>(() => PatientTriageController());
  }
}
