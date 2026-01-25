import 'package:estacionaqui/app/components/ui/Scaffold_UI.dart';
import 'package:estacionaqui/app/components/ui/anxiety_dropdown_ui.dart';
import 'package:estacionaqui/app/components/ui/dificulty_input.dart';
import 'package:estacionaqui/app/components/ui/disclaimer_ui.dart';
import 'package:estacionaqui/app/components/ui/feels_dropdown_ui.dart';
import 'package:estacionaqui/app/modules/patient/triage/patrient_triage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientTriageView extends GetView<PatientTriageController> {
  const PatientTriageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldUI(
      title: 'Triagem Inicial',
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}
