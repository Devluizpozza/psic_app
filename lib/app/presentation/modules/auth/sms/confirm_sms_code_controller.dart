import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/presentation/shared/handlers/snack_bar_handler.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/data/repositories/app_user_repository.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class ConfirmSmsCodeController extends GetxController {
  final TextEditingController codeController = TextEditingController();
  final AppUserRepository appUserRepository = AppUserRepository();
  late String verificationId;
  late String phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map;
    verificationId = args['verificationId'];
    phoneNumber = args['phoneNumber'];
  }

  Future<void> confirmCode() async {
    String smsCode = codeController.text.trim();

    if (smsCode.isEmpty) {
      SnackBarHandler.snackBarError("Por favor, insira o código.");
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      if (user != null) {
        AppUser remoteUser = await appUserRepository.fetch(user.uid);

        if (remoteUser.name.isEmpty) {
          Get.toNamed(
            AppRoutes.register_user,
            arguments: {'userUID': user.uid, 'phoneNumber': phoneNumber},
          );
        } else {
          Get.toNamed(AppRoutes.initial, arguments: user.uid);
        }
      }
    } catch (e) {
      SnackBarHandler.snackBarError("Erro ao confirmar o código.");
      Logger.info(e.toString());
    }
  }
}
