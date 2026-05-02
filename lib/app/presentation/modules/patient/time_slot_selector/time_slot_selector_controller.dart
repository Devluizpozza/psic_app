import 'package:get/get.dart';
import 'package:psicApp/app/presentation/shared/controllers/triage_shared_controller.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/data/datasources/firestore/collections.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/presentation/shared/handlers/snack_bar_handler.dart';
import 'package:psicApp/app/domain/models/event_date_time.dart';
import 'package:psicApp/app/domain/models/schedule.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';
import 'package:psicApp/app/data/repositories/schedule_repository.dart';
import 'package:psicApp/app/data/repositories/time_slot_repository.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/core/logger/logger.dart';

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
