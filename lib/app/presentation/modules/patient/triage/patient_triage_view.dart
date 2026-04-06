import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/presentation/shared/components/scaffold_ui.dart';
import 'package:psicApp/app/presentation/shared/components/anxiety_dropdown_ui.dart';
import 'package:psicApp/app/presentation/shared/components/difficulty_input.dart';
import 'package:psicApp/app/presentation/shared/components/disclaimer_ui.dart';
import 'package:psicApp/app/presentation/shared/components/feels_dropdown_ui.dart';
import 'package:psicApp/app/presentation/modules/patient/triage/patient_triage_controller.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';

class PatientTriageView extends GetView<PatientTriageCompController> {
  const PatientTriageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldUI(
      title: 'Triagem Inicial',
      backgroundColor: AppColors.neutralMist,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            SizedBox(height: 15),
            FeelsDropdown(controller),
            const SizedBox(height: 20),
            AnxietyDropdown(controller),
            const SizedBox(height: 20),
            DifficultyField(
              (value) => controller.difficultyController.text = value,
            ),
            const SizedBox(height: 24),
            Disclaimer(),
            const SizedBox(height: 32),
            // ScheduleButton(controller, controller.submitTriage),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: () => controller.submitTriage(),
          child: const Icon(Icons.arrow_forward, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
