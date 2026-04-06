import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/presentation/shared/handlers/snack_bar_handler.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';
import 'package:psicApp/app/data/repositories/app_user_repository.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class RegisterUserController extends GetxController {
  final AppUserRepository appUserRepository = AppUserRepository();
  late String userUID;
  late String phoneNumber;
  late String email;
  late UserRoleType userRoleType;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contatoController = TextEditingController();

  final RxBool _isEditing = false.obs;
  final RxBool _isLoading = false.obs;

  bool get isEditing => _isEditing.value;

  set isEditing(bool value) {
    _isEditing.value = value;
    _isEditing.refresh();
  }

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

  @override
  void onInit() {
    final Map<String, dynamic>? arguments = Get.arguments;
    if (arguments != null) {
      userUID = arguments['userUid'];
    }
    super.onInit();
  }

  Future<void> createUser() async {
    try {
      AppUser remoteUser = await appUserRepository.fetch(userUID);
      AppUser userToSave = remoteUser.copyWith({
        "name": nameController.text,
        "email": emailController.text,
        "contact":
            contatoController.text.startsWith('+55')
                ? contatoController.text
                : "+55${contatoController.text}",
      });

      bool success = await appUserRepository.update(userToSave);
      if (success) {
        UserController.instance.fetch(userToSave.uid);
        SnackBarHandler.snackBarSuccess('Usuário criado com sucesso!');
        Get.toNamed(AppRoutes.home);
      }
    } catch (e) {
      Logger.info(e.toString());
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   nameController.dispose();
  //   placaController.dispose();
  //   contatoController.dispose();
  //   emailController.dispose();
  // }
}
