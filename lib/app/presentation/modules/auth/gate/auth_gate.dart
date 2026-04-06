import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/presentation/shared/controllers/auth_manager.dart';

class AuthGate extends GetView<AuthManager> {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.firebaseUser.value;

      // Aguarda o primeiro frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (user == null) {
          Get.offAllNamed(AppRoutes.login);
        } else {
          Get.offAllNamed(AppRoutes.home);
        }
      });

      // Tela neutra enquanto decide
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
