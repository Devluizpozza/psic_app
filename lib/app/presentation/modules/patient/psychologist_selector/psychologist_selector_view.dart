import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/presentation/shared/components/scaffold_ui.dart';
import 'package:psicApp/app/presentation/shared/components/psychologist_card_ui.dart';
import 'package:psicApp/app/domain/models/psychologist.dart';
import 'package:psicApp/app/presentation/modules/patient/psychologist_selector/psychologist_selector_controller.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';

class PsychologistSelectorView extends GetView<PsychologistSelectorController> {
  const PsychologistSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldUI(
      title: 'Selecione um profissional',
      backgroundColor: AppColors.neutralMist,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,

          child: Obx(
            () => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              itemCount: controller.psychologists.length,
              itemBuilder: (item, index) {
                Psychologist psyc = controller.psychologists[index];
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 150,
                      child: PsychologistCard(
                        psychologist: psyc,
                        selected: controller.isSelected(psyc),
                        onTap: () => controller.selectPsychologist(psyc),
                        selectedColor: AppColors.calmSage,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: () => controller.submitPsychologistAfterTriage(),
          child: const Icon(Icons.arrow_forward, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
