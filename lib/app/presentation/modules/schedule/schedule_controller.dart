import 'package:get/get.dart';
import 'package:psicApp/app/core/logger/logger.dart';
import 'package:psicApp/app/data/repositories/schedule_repository.dart';
import 'package:psicApp/app/domain/models/schedule.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';

class ScheduleController extends GetxController {
  final Rx<List<Schedule>> _schedules = Rx<List<Schedule>>([]);
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  String get psyUid => UserController.instance.user!.uid;

  List<Schedule> get schedules => _schedules.value;

  set schedules(List<Schedule> value) {
    _schedules.value = value;
    _schedules.refresh();
  }

  @override
  void onInit() async {
    await listsSchedulesByPsyId();
    super.onInit();
  }

  Future<void> listsSchedulesByPsyId() async {
    try {
      schedules = await scheduleRepository.listByPsyId(psyUid);
    } catch (e) {
      Logger.info(e.toString());
    }
  }
}
