import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/data/repositories/app_user_repository.dart';
import 'package:psicApp/app/presentation/shared/controllers/auth_manager.dart';
import 'package:psicApp/app/core/logger/logger.dart';
import 'package:psicApp/app/core/utils/regex_utils.dart';

class LoginController extends GetxController {
  final Rx<String> _phoneNumber = ''.obs;
  final Rx<String> _smsCode = ''.obs;
  final AppUserRepository appUserRepository = AppUserRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get phoneNumber => Regex.only_digits(_phoneNumber.value);

  set phoneNumber(String value) {
    _phoneNumber.value = value;
    _phoneNumber.refresh();
  }

  String get smsCode => _smsCode.value;

  set onSmsCodeChanged(String value) {
    _smsCode.value = value;
    _smsCode.refresh();
  }

  void registerWithPhoneNumber() async {
    AuthManager.instance.verifyPhoneNumber("+55$phoneNumber");
  }

  void signInWithGoogle() {
    try {
      AuthManager.to.signInWithGoogle();
    } catch (e) {
      Logger.info(e.toString());
    }
  }
}
