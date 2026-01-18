import 'package:estacionaqui/app/components/ui/input_container_ui.dart';
import 'package:estacionaqui/app/modules/patient/triage/patrient_triage_controller.dart';
import 'package:flutter/material.dart';

class DifficultyField extends StatelessWidget {
  final PatientTriageController controller;

  const DifficultyField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Principal dificuldade',
          hintText: 'Se quiser, descreva com suas próprias palavras...',
        ),
        onChanged: controller.setDifficulty,
      ),
    );
  }
}
