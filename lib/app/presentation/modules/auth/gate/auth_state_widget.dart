import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/presentation/modules/home/home_view.dart';
import 'package:psicApp/app/presentation/modules/auth/login/login_view.dart';
import 'package:psicApp/app/presentation/shared/controllers/auth_manager.dart';

class AuthStateWidget extends StatelessWidget {
  const AuthStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final auth = AuthManager.to;
      if (auth.isLoggedIn) {
        return const HomeView();
      } else {
        return const LoginView();
      }
    });
  }
}
