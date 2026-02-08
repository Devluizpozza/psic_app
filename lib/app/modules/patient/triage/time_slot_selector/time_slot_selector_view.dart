import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/components/ui/Scaffold_UI.dart';
import 'package:psicApp/app/components/ui/cards/time_slot_card_ui.dart';
import 'package:psicApp/app/components/ui/schedule_button_ui.dart';
import 'package:psicApp/app/models/time_slot_model.dart';
import 'package:psicApp/app/modules/patient/triage/time_slot_selector/time_slot_selector_controller.dart';
import 'package:psicApp/app/utils/app_colors.dart';

class TimeSlotSelectorView extends GetView<TimeSlotSelectorController> {
  const TimeSlotSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldUI(
      title: 'Selecione um horario',
      backgroundColor: AppColors.neutralMist,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,

          child: Obx(
            () => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              itemCount: controller.timesSlot.length + 1,
              itemBuilder: (item, index) {
                if (index == controller.timesSlot.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 16,
                    ),
                    child: ScheduleButton(
                      onPressed:
                          () => controller.submitPsychologistAfterTriage(),
                    ),
                  );
                }
                TimeSlot timeSlot = controller.timesSlot[index];
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 80,
                      child: TimeSlotCardui(
                        timeSlot: timeSlot,
                        selected: controller.isSelected(timeSlot),
                        onTap: () => controller.selectTimeSlot(timeSlot),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
