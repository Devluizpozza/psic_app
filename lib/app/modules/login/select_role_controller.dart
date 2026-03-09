import 'package:get/get.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/models/app_user_model.dart';
import 'package:psicApp/app/repositories/app_user_repository.dart';
import 'package:psicApp/app/repositories/patient_repository.dart';
import 'package:psicApp/app/repositories/psychologist_repository.dart';
import 'package:psicApp/app/routes/app_routes.dart';
import 'package:psicApp/app/utils/logger.dart';

class SelectRoleController extends GetxController {
  final Rx<int> _selectedIndex = Rx<int>(0);
  AppUserRepository appUserRepository = AppUserRepository();
  PatientRepository patientRepository = PatientRepository();
  PsychologistRepository psychologistRepository = PsychologistRepository();
  final Rx<UserRoleType> _userRoleType = Rx<UserRoleType>(UserRoleType.none);
  late String userUID;
  late String phoneNumber;
  late String email;

  final RxBool _isEditing = false.obs;
  final RxBool _isLoading = false.obs;

  @override
  void onInit() {
    final Map<String, dynamic>? arguments = Get.arguments;
    if (arguments != null) {
      userUID = arguments['userUid'];
      phoneNumber = arguments['phoneNumber'] ?? '';
      email = arguments['email'] ?? '';
    }
    super.onInit();
  }

  UserRoleType get userRoleType =>
      selectedIndex == 0 ? UserRoleType.patient : UserRoleType.psychologist;

  set userRoleType(UserRoleType value) {
    _userRoleType.value = value;
    _userRoleType.refresh();
  }

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int value) {
    _selectedIndex.value = value;
    _selectedIndex.refresh();
  }

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

  void handleRoleIndex(int index) {
    selectedIndex = index;
  }

  void sendRoleToRegisterView() async {
    try {
      if (userRoleType != UserRoleType.none) {
        AppUser remoteUser = await appUserRepository.fetch(userUID);
        if (remoteUser.uid.isNotEmpty) {
          AppUser userAfterCopyWith = remoteUser.copyWith({
            "userType": userRoleType,
            "onboardingStepType": OnboardingStepType.role_selected.name,
          });
          await appUserRepository.update(userAfterCopyWith);
          // if (success) {
          //   SnackBarHandler.snackBarSuccess(
          //     "A role do usuário ${remoteUser.name} foi adicionada.",
          //   );

          //   if (userAfterCopyWith.userType == UserRoleType.patient) {
          //     Patient patientToSave = Patient(
          //       uid: remoteUser.uid,
          //       name: '',
          //       contact: phoneNumber,
          //       email: email,
          //       createdAt: DateTime.now(),
          //       imageUrl: '',
          //     );
          //     await patientRepository.create(patientToSave);
          //   }
          // }

          // if (userAfterCopyWith.userType == UserRoleType.psychologist) {
          //   Psychologist psychologistToSave = Psychologist(
          //     uid: remoteUser.uid,
          //     name: '',
          //     contact: phoneNumber,
          //     email: email,
          //     createdAt: DateTime.now(),
          //     imageUrl: '',
          //   );
          //   await psychologistRepository.create(psychologistToSave);
          // }

          Get.toNamed(
            AppRoutes.register_user,
            arguments: {"userUid": remoteUser.uid},
          );
        }
      }
    } catch (e) {
      Logger.info(e.toString());
    }
  }
}
