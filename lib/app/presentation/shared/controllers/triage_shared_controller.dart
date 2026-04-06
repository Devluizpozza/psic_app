import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/domain/models/psychologist.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';

class TriageCompController extends GetxController {
  final Rx<FeelsType> _feels = Rx<FeelsType>(FeelsType.none);
  final Rx<AnxietyType> _anxiety = Rx<AnxietyType>(AnxietyType.none);
  final _difficulty = ''.obs;
  final Rx<Psychologist?> _psychologist = Rx<Psychologist?>(null);
  final Rx<TimeSlot?> _timeSlot = Rx<TimeSlot?>(null);
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

  Psychologist? get psychologist => _psychologist.value;

  set psychologist(Psychologist? value) {
    _psychologist.value = value;
    _psychologist.refresh();
  }

  TimeSlot? get timeSlot => _timeSlot.value;

  set timeSlot(TimeSlot? value) {
    _timeSlot.value = value;
    _timeSlot.refresh();
  }

  void reset() {
    timeSlot = null;
    psychologist = null;
    difficulty = '';
    anxiety = AnxietyType.none;
    feels = FeelsType.none;
  }
}
