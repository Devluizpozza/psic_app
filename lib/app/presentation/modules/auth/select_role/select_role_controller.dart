import 'package:get/get.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/domain/models/patient.dart';
import 'package:psicApp/app/domain/models/psychologist.dart';
import 'package:psicApp/app/data/repositories/app_user_repository.dart';
import 'package:psicApp/app/data/repositories/patient_repository.dart';
import 'package:psicApp/app/data/repositories/psychologist_repository.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/core/logger/logger.dart';

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

          if (userAfterCopyWith.userType == UserRoleType.patient) {
            await patientRepository.create(
              Patient(
                uid: remoteUser.uid,
                name: '',
                contact: phoneNumber,
                email: email,
                createdAt: DateTime.now(),
              ),
            );
          } else if (userAfterCopyWith.userType == UserRoleType.psychologist) {
            await psychologistRepository.create(
              Psychologist(
                uid: remoteUser.uid,
                name: '',
                contact: phoneNumber,
                email: email,
                createdAt: DateTime.now(),
              ),
            );
          }

          Get.toNamed(
            AppRoutes.register_user,
            arguments: {'userUid': remoteUser.uid},
          );
        }
      }
    } catch (e) {
      Logger.info(e.toString());
    }
  }
}
