import 'package:estacionaqui/app/components/ui/Scaffold_UI.dart';
import 'package:estacionaqui/app/modules/home/sections/good_news_section.dart';
import 'package:estacionaqui/app/modules/home/sections/motivation_section.dart';
import 'package:estacionaqui/app/modules/schedule/schedule_controller.dart';
import 'package:estacionaqui/app/routes/app_routes.dart';
import 'package:estacionaqui/app/services/auth_manager.dart';
import 'package:estacionaqui/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldUI(
      appBar: AppBar(
        title: Text("Agendamento"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.person, size: 26),
              onPressed: () => {},
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.softMint),
              child: Text(
                'Psic_App',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.read_more_outlined),
              title: Text('Agendamentos'),
              onTap: () => Get.toNamed(AppRoutes.parking_owner_list),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () => Get.toNamed(AppRoutes.user_profile),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () => AuthManager.instance.signOut(),
            ),
          ],
        ),
      ),
      title: 'Início',
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MotivationSection(),
            const SizedBox(height: 40),
            GoodNewsSection(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        backgroundColor: AppColors.softPeach,
        onPressed: () => Get.toNamed(AppRoutes.patient_triage),
        // onPressed: controller.createPsychologist,
        child: const Icon(Icons.reviews_outlined, color: Colors.black),
      ),
    );
  }
}
