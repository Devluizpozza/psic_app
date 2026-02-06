import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/comp/triage_controller_comp.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/routes/app_routes.dart';

class PatientTriageController extends GetxController {
  final Rx<FeelsType> _feels = Rx<FeelsType>(FeelsType.none);
  final Rx<AnxietyType> _anxiety = Rx<AnxietyType>(AnxietyType.none);
  final TextEditingController difficultyController = TextEditingController();
  final difficulty = ''.obs;

  List<FeelsType> get feelsOptions =>
      FeelsType.values.where((e) => (e.name != FeelsType.none.name)).toList();
  List<AnxietyType> get anxietyOptions =>
      AnxietyType.values
          .where((e) => (e.name != AnxietyType.none.name))
          .toList();
  FeelsType get feels => _feels.value;

  set feels(FeelsType value) {
    _feels.value = value;
    _feels.refresh();
  }

  AnxietyType get anxiety => _anxiety.value;

  set anxiety(AnxietyType value) {
    _anxiety.value = value;
    _anxiety.refresh();
  }

  void setDifficulty(String value) => difficulty.value = value;

  bool get isFormValid => difficulty.value.trim().isNotEmpty;

  void submitTriage() {
    final triageController = Get.find<TriageController>();
    triageController.feels = feels;
    triageController.anxiety = anxiety;
    triageController.difficulty = difficultyController.text;
    Get.toNamed(AppRoutes.psychologist_selector);
  }
}
