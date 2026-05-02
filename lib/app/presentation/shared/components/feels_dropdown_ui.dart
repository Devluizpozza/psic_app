import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:psicApp/app/presentation/shared/components/input_container_ui.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/presentation/modules/patient/triage/patient_triage_controller.dart';

class FeelsDropdown extends StatelessWidget {
  final PatientTriageCompController controller;

  const FeelsDropdown(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Obx(
        () => DropdownButtonFormField<FeelsType>(
          value: controller.feels,
          decoration: const InputDecoration(
            labelText: 'Como você está se sentindo?',
          ),
          items:
              controller.feelsOptions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name), // enum já em PT
                    ),
                  )
                  .toList(),
          onChanged: controller.setFeels,
        ),
      ),
    );
  }
}
