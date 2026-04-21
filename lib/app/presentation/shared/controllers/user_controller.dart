import 'package:get/get.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/data/repositories/app_user_repository.dart';
import 'package:psicApp/app/presentation/shared/controllers/auth_manager.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class UserController extends GetxController {
  final Rx<AppUser?> _user = Rx<AppUser?>(null);
  final AppUserRepository appUserRepository = AppUserRepository();

  static UserController get instance => Get.find<UserController>();

  AppUser? get user => _user.value;

  set user(AppUser? value) {
    _user.value = value;
    _user.refresh();
  }

  Future<AppUser?> fetch(String uid) async {
    try {
      AppUserRepository appUserRepository = AppUserRepository();
      AppUser? remoteUser = await appUserRepository.fetch(uid);

      // Só desloga se o documento realmente não existe no Firestore
      if (remoteUser.uid.isEmpty) {
        Logger.info("Usuário não encontrado no Firestore.");
        return null;
      }

      user = remoteUser;
      return remoteUser;
    } catch (e) {
      Logger.info(e);
      return Future.error(e.toString());
    }
  }

  void clear() {
    user = null;
  }
}
