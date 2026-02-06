import 'package:get/get.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/db/collections.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/models/psychologist_model.dart';
import 'package:psicApp/app/repositories/psychologist_repository.dart';
import 'package:psicApp/app/utils/logger.dart';

class PsychologistSelectorController extends GetxController {
  final PsychologistRepository psychologistRepository =
      PsychologistRepository();
  final Rx<List<Psychologist>> _psychologists = Rx<List<Psychologist>>([]);
  final Rx<Psychologist?> selectedPsychologist = Rx<Psychologist?>(null);
  late FeelsType feels;
  late AnxietyType anxiety;
  late String difficulty;

  void selectPsychologist(Psychologist psychologist) {
    selectedPsychologist.value = psychologist;
  }

  bool isSelected(Psychologist psychologist) {
    return selectedPsychologist.value?.uid == psychologist.uid;
  }

  List<Psychologist> get psychologists => _psychologists.value;

  set psychologists(List<Psychologist> value) {
    _psychologists.value = value;
    _psychologists.refresh();
  }

  @override
  void onInit() async {
    final Map<String, dynamic>? arguments = Get.arguments;

    if (arguments != null) {
      feels = arguments['feels'];
      anxiety = arguments['anxiety'];
      difficulty = arguments['difficulty'] ?? '';
    }
    await listPsychologists();
    super.onInit();
  }

  Future<void> listPsychologists() async {
    try {
      psychologists = await psychologistRepository.list();
    } catch (e) {
      Logger.info(e.toString());
    }
  }

  Future<void> createPsychologist() async {
    try {
      Psychologist psy = Psychologist(
        name: "Joao Paulo figueiredo",
        contact: "4899999999",
        createAt: DateTime.now(),
        email: "teste@gmail.com",
        uid: DB.generateUID(Collections.psychologist),
        specialty: SpecialtyType.clinico,
      );

      PsychologistRepository psychologistRepository = PsychologistRepository();
      bool success = await psychologistRepository.create(psy);
      print("$success");
    } catch (e) {
      throw Exception("$e");
    }
  }
}
