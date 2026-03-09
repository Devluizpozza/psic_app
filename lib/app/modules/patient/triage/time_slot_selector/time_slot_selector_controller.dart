import 'package:get/get.dart';
import 'package:psicApp/app/comp/triage_controller_comp.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/db/collections.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/handlers/snack_bar_handler.dart';
import 'package:psicApp/app/models/event_date_time_model.dart';
import 'package:psicApp/app/models/schedule_model.dart';
import 'package:psicApp/app/models/time_slot_model.dart';
import 'package:psicApp/app/modules/user/user_controller.dart';
import 'package:psicApp/app/repositories/schedule_repository.dart';
import 'package:psicApp/app/repositories/time_slot_repository.dart';
import 'package:psicApp/app/routes/app_routes.dart';
import 'package:psicApp/app/utils/logger.dart';

class TimeSlotSelectorController extends GetxController {
  final TimeSlotRepository timeSlotRepository = TimeSlotRepository();
  final ScheduleRepository scheduleRepository = ScheduleRepository();
  final triageCompController = Get.put(TriageCompController());
  final Rx<List<TimeSlot>> _timesSlot = Rx<List<TimeSlot>>([]);
  final Rx<TimeSlot?> _selectedTimeSlot = Rx<TimeSlot?>(null);
  late FeelsType feels;
  late AnxietyType anxiety;
  late String difficulty;

  void selectTimeSlot(TimeSlot timeSlot) {
    _selectedTimeSlot.value = timeSlot;
  }

  bool isSelected(TimeSlot timeSlot) {
    return _selectedTimeSlot.value?.uid == timeSlot.uid;
  }

  bool get hasSelectedTimeSlot => selectedTimeSlot != null;

  List<TimeSlot> get timesSlot => _timesSlot.value;

  set timesSlot(List<TimeSlot> value) {
    _timesSlot.value = value;
    _timesSlot.refresh();
  }

  TimeSlot? get selectedTimeSlot => _selectedTimeSlot.value;

  set selectedTimeSlot(TimeSlot? value) {
    _selectedTimeSlot.value = value;
    _selectedTimeSlot.refresh();
  }

  @override
  void onInit() async {
    await listTimeSlots();
    super.onInit();
  }

  Future<void> listTimeSlots() async {
    try {
      String psychologistId = triageCompController.psychologist!.uid;
      timesSlot = await timeSlotRepository.listByPsychologistId(psychologistId);
    } catch (e) {
      Logger.info(e.toString());
    }
  }


  void submitPsychologistAfterTriage() async {
    try {
      triageCompController.timeSlot = selectedTimeSlot;
      EventDateTime eventDateTimeToSchedule = EventDateTime(
        createdAt: DateTime.now(),
        startAt: selectedTimeSlot!.startAt,
        endAt: selectedTimeSlot!.endAt,
        timeZone: "GMT-3",
      );
      Schedule scheduleToSave = Schedule(
        uid: DB.generateUID(Collections.time_slot),
        psychologistId: triageCompController.psychologist!.uid,
        ownerId: UserController.instance.user!.uid,
        statusType: ScheduleStatusType.requested,
        eventDateTime: eventDateTimeToSchedule,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        metadata: {},
      );

      bool success = await scheduleRepository.create(scheduleToSave);
      if (success) {
        triageCompController.reset();
        SnackBarHandler.snackBarSuccess(
          "Agendamento ${scheduleToSave.uid} foi solicitado, aguarde a confirmação do profissional",
        );
        Get.toNamed(AppRoutes.home);
      }
    } catch (e) {
      Logger.info(e.toString());
    }
  }
}
