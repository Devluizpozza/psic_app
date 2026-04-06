import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:psicApp/app/presentation/shared/components/input_container_ui.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/presentation/modules/patient/triage/patient_triage_controller.dart';

class AnxietyDropdown extends StatelessWidget {
  final PatientTriageCompController controller;

  const AnxietyDropdown(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Obx(
        () => DropdownButtonFormField<AnxietyType>(
          value: controller.anxiety,
          decoration: const InputDecoration(labelText: 'Nível de ansiedade'),
          items:
              controller.anxietyOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
          onChanged: controller.setAnxiety,
        ),
      ),
    );
  }
}
