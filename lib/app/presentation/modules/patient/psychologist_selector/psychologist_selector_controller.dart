import 'package:get/get.dart';
import 'package:psicApp/app/presentation/shared/controllers/triage_shared_controller.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/data/datasources/firestore/collections.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/domain/models/psychologist.dart';
import 'package:psicApp/app/data/repositories/psychologist_repository.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class PsychologistSelectorController extends GetxController {
  final PsychologistRepository psychologistRepository =
      PsychologistRepository();
  final triageCompController = Get.put(TriageCompController());

  final Rx<List<Psychologist>> _psychologists = Rx<List<Psychologist>>([]);
  final Rx<Psychologist?> _selectedPsychologist = Rx<Psychologist?>(null);
  late FeelsType feels;
  late AnxietyType anxiety;
  late String difficulty;

  void selectPsychologist(Psychologist psychologist) {
    _selectedPsychologist.value = psychologist;
  }

  bool isSelected(Psychologist psychologist) {
    return _selectedPsychologist.value?.uid == psychologist.uid;
  }

  List<Psychologist> get psychologists => _psychologists.value;

  set psychologists(List<Psychologist> value) {
    _psychologists.value = value;
    _psychologists.refresh();
  }

  Psychologist? get selectedPsychologist => _selectedPsychologist.value;

  set selectedPsychologist(Psychologist? value) {
    _selectedPsychologist.value = value;
    _selectedPsychologist.refresh();
  }

  @override
  void onInit() async {
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
        createdAt: DateTime.now(),
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

  void submitPsychologistAfterTriage() {
    triageCompController.psychologist = selectedPsychologist;
    Get.toNamed(AppRoutes.timeSlot_selector);
  }
}
