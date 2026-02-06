import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/models/psychologist_model.dart';

class TriageController extends GetxController {
  final Rx<FeelsType> _feels = Rx<FeelsType>(FeelsType.none);
  final Rx<AnxietyType> _anxiety = Rx<AnxietyType>(AnxietyType.none);
  final _difficulty = ''.obs;
    final selectedPsychologist = Rx<Psychologist?>(null);
  final selectedDateTime = Rx<DateTime?>(null);

  FeelsType get feels => _feels.value;

  set feels(FeelsType value) {
    _feels.value = value;
    _feels.refresh();
  }

  AnxietyType get anxiety => _anxiety.value;

  set anxiety(AnxietyType value) {
    _anxiety.value = value;
    _feels.refresh();
  }

  String get difficulty => _difficulty.value;

  set difficulty(String value) {
    _difficulty.value = value;
    _difficulty.refresh();
  }

}
