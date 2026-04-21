import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/presentation/shared/controllers/auth_manager.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final firebaseUser = Get.find<AuthManager>().firebaseUser.value;
      final appUser = Get.find<UserController>().user;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (firebaseUser == null) {
          Get.offAllNamed(AppRoutes.login);
          return;
        }

        // Aguarda o fetch do AppUser completar
        if (appUser == null) return;

        switch (appUser.onboardingStepType) {
          case OnboardingStepType.finished:
            Get.offAllNamed(AppRoutes.home);
            break;
          case OnboardingStepType.role_selected:
            Get.offAllNamed(
              AppRoutes.register_user,
              arguments: {'userUid': appUser.uid},
            );
            break;
          case OnboardingStepType.phone_verified:
          case OnboardingStepType.none:
          default:
            Get.offAllNamed(
              AppRoutes.select_role,
              arguments: {'userUid': appUser.uid},
            );
        }
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
