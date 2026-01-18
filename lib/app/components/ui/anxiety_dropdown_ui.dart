import 'package:estacionaqui/app/components/ui/input_container_ui.dart';
import 'package:estacionaqui/app/consts/enums.dart';
import 'package:estacionaqui/app/modules/patient/triage/patrient_triage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AnxietyDropdown extends StatelessWidget {
  final PatientTriageController controller;

  const AnxietyDropdown(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Obx(
        () => DropdownButtonFormField<AnsietyType>(
          value: controller.anxiety.value,
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
