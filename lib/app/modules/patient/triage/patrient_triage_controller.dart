import 'package:estacionaqui/app/consts/enums.dart';
import 'package:get/get.dart';

class PatientTriageController extends GetxController {
  final Rx<FeelsType?> feels = Rx<FeelsType?>(null);
  final Rx<AnsietyType?> anxiety = Rx<AnsietyType?>(null);

  final difficulty = ''.obs;
  List<FeelsType> get feelsOptions =>
      FeelsType.values.where((e) => (e.name != FeelsType.none.name)).toList();
  List<AnsietyType> get anxietyOptions =>
      AnsietyType.values
          .where((e) => (e.name != AnsietyType.none.name))
          .toList();
  void setFeels(FeelsType? value) => feels.value = value;
  void setAnxiety(AnsietyType? value) => anxiety.value = value;
  void setDifficulty(String value) => difficulty.value = value;

  bool get isFormValid =>
      feels.value != null &&
      anxiety.value != null &&
      difficulty.value.trim().isNotEmpty;

  void submitTriage() {
    final data = {
      'feels': feels.value,
      'anxiety': anxiety.value,
      'difficulty': difficulty.value,
    };
    print('Triagem enviada: $data');
  }
}
