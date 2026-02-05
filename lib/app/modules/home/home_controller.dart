import 'package:estacionaqui/app/consts/enums.dart';
import 'package:estacionaqui/app/db/collections.dart';
import 'package:estacionaqui/app/db/db.dart';
import 'package:estacionaqui/app/handlers/snack_bar_handler.dart';
import 'package:estacionaqui/app/models/event_date_time_model.dart';
import 'package:estacionaqui/app/models/psychologist_model.dart';
import 'package:estacionaqui/app/models/schedule_model.dart';
import 'package:estacionaqui/app/models/time_slot_model.dart';
import 'package:estacionaqui/app/repositories/psychologist_repository.dart';
import 'package:estacionaqui/app/repositories/schedule_repository.dart';
import 'package:estacionaqui/app/repositories/time_slot_repository.dart';
import 'package:estacionaqui/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, RouteAware {
  final TimeSlotRepository timeSlotRepository = TimeSlotRepository();
  final ScheduleRepository scheduleRepository = ScheduleRepository();
  late AnimationController animationController;
  late List<Animation<Offset>> animations;

  @override
  void onInit() {
    // final Map<String, dynamic> data = Get.arguments;
    // if (data.isNotEmpty) {
    // userUID = data['userUID'];
    // }
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animations = List.generate(6, (index) {
      return Tween<Offset>(
        begin: const Offset(-1.5, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(
            index * 0.12,
            0.12 + index * 0.12,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    animationController.forward();
    super.onInit();
  }

  void navigateTo(String route) async {
    await Get.toNamed(route);
    update();
  }

  @override
  void didPopNext() {
    animationController.reset();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  Future<void> launcherUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir';
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> createPsychologist() async {
    try {
      Psychologist psy = Psychologist(
        name: "teste 3",
        contact: "3",
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

  void createTimeSlot() async {
    try {
      String psycId = "EtnhhmQiCm69W3kmSAFr";
      final now = DateTime.now();
      final startAtToSave = DateTime(now.year, now.month, now.day, 16, 0);
      final endAtToSave = startAtToSave.add(const Duration(minutes: 50));
      TimeSlot timeSlotToSave = TimeSlot(
        uid: DB.generateUID(Collections.time_slot),
        psychologistId: psycId,
        startAt: startAtToSave,
        endAt: endAtToSave,
        isAvailable: true,
      );
      bool success = await timeSlotRepository.create(
        timeSlotToSave.psychologistId,
        timeSlotToSave,
      );
      if (success) {
        SnackBarHandler.snackBarSuccess(
          "Sucesso, ${timeSlotToSave.uid} criado",
        );
      }
    } catch (e) {
      Logger.info(e.toString());
    }
  }

  void createSchedule() async {
    try {
      final now = DateTime.now();
      final startAtToSave = DateTime(now.year, now.month, now.day, 16, 0);
      final endAtToSave = startAtToSave.add(const Duration(minutes: 50));
      EventDateTime eventDateTimeToSave = EventDateTime(
        createdAt: DateTime.now(),
        endAt: endAtToSave,
        startAt: startAtToSave,
        timeZone: "",
      );
      Schedule scheduleToSave = Schedule(
        uid: DB.generateUID(Collections.schedule),
        psychologistId: "EtnhhmQiCm69W3kmSAFr",
        ownerId: "EtnhhmQiCm69W3kmSAFr",
        statusType: ScheduleStatusType.none,
        createdAt: DateTime.now(),
        eventDateTime: eventDateTimeToSave,
        metadata: {},
        updatedAt: DateTime.now(),
      );
      bool success = await scheduleRepository.create(scheduleToSave);
      if (success) {
        SnackBarHandler.snackBarSuccess(
          "Sucesso, ${scheduleToSave.uid} criado",
        );
      }
    } catch (e) {
      Logger.info(e.toString());
    }
  }
}
