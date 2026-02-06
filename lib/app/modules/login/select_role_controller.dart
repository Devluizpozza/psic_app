import 'package:get/get.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/repositories/app_user_repository.dart';
import 'package:psicApp/app/routes/app_routes.dart';

class SelectRoleController extends GetxController {
  final AppUserRepository appUserRepository = AppUserRepository();
  final Rx<int> _selectedIndex = Rx<int>(0);
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
      userUID = arguments['userUID'];
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

  void sendRoleToRegisterView() {
    Get.toNamed(
      AppRoutes.register_user,
      arguments: {
        'userRoleType': userRoleType,
        "userUID": userUID,
        "phoneNumber": phoneNumber,
        "email": email,
      },
    );
  }
}
