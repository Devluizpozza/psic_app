import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/presentation/shared/components/selectable_square_card.dart';
import 'package:psicApp/app/presentation/modules/auth/select_role/select_role_controller.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';

class SelectRoleView extends GetView<SelectRoleController> {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(""), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Bem-vindo ao PsicApp",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Entre usando seu número de celular",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF34495E)),
              ),
              SizedBox(height: 25),
              Obx(
                () => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableSquareCard(
                        icon: Icons.person,
                        iconSize: 50,
                        label: 'PACIENTE',
                        selected: controller.selectedIndex == 0,
                        selectedColor: AppColors.confidenceBlue,
                        onTap: () => controller.handleRoleIndex(0),
                      ),
                      SizedBox(height: 15),
                      SelectableSquareCard(
                        icon: Icons.person_search_sharp,
                        iconSize: 50,
                        label: 'PSICÓLOGO',
                        selected: controller.selectedIndex == 1,
                        selectedColor: Colors.teal,
                        onTap: () => controller.handleRoleIndex(1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: () => controller.sendRoleToRegisterView(),
          child: const Icon(Icons.arrow_forward, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
