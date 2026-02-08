import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/comp/triage_controller_comp.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/routes/app_routes.dart';

class PatientTriageCompController extends GetxController {
  final triageCompController = Get.put(TriageCompController());
  final Rx<FeelsType> _feels = Rx<FeelsType>(FeelsType.none);
  final Rx<AnxietyType> _anxiety = Rx<AnxietyType>(AnxietyType.none);
  final TextEditingController difficultyController = TextEditingController();
  final difficulty = ''.obs;

  List<FeelsType> get feelsOptions => FeelsType.values.toList();
  List<AnxietyType> get anxietyOptions => AnxietyType.values.toList();

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
  void setFeels(FeelsType? value) => _feels.value = value!;
  void setAnxiety(AnxietyType? value) => _anxiety.value = value!;

  bool get isFormValid => difficulty.value.trim().isNotEmpty;
  void submitTriage() {
    triageCompController.feels = feels;
    triageCompController.anxiety = anxiety;
    triageCompController.difficulty = difficultyController.text;
    Get.toNamed(AppRoutes.psychologist_selector);
  }
}
