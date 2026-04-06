import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/patient/triage/patient_triage_controller.dart';

class PatientTriageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTriageCompController>(
      () => PatientTriageCompController(),
    );
  }
}
