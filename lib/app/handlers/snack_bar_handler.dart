import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SnackBarHandler {
  static void snackBarError(
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
      borderRadius: 12,
      duration: duration,
    );
  }

  static void snackBarSuccess(
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      'Success',
      message,

      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
      borderRadius: 12,
      duration: duration,
    );
  }

  static void snackBarSuccessLogin(String userName) {
    Get.snackbar(
      "Bem-vindo de volta!",
      "Ótimo te ver novamente, $userName!",
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
