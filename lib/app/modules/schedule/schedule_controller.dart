import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/db/collections.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/models/psychologist_model.dart';
import 'package:psicApp/app/repositories/psychologist_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleController extends GetxController
    with GetSingleTickerProviderStateMixin, RouteAware {
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
}
