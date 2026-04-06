import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:psicApp/app/presentation/modules/agenda/agenda_bindings.dart';
import 'package:psicApp/app/presentation/modules/agenda/agenda_view.dart';
import 'package:psicApp/app/presentation/modules/home/home_bindings.dart';
import 'package:psicApp/app/presentation/modules/home/home_view.dart';
import 'package:psicApp/app/presentation/modules/auth/login/login_bindings.dart';
import 'package:psicApp/app/presentation/modules/auth/login/login_view.dart';
import 'package:psicApp/app/presentation/modules/auth/register/register_user_bindings.dart';
import 'package:psicApp/app/presentation/modules/auth/register/register_user_view.dart';
import 'package:psicApp/app/presentation/modules/auth/select_role/select_role_bindings.dart';
import 'package:psicApp/app/presentation/modules/auth/select_role/select_role_view.dart';
import 'package:psicApp/app/presentation/modules/patient/time_slot_selector/time_slot_selector_bindings.dart';
import 'package:psicApp/app/presentation/modules/patient/time_slot_selector/time_slot_selector_view.dart';
import 'package:psicApp/app/presentation/modules/patient/triage/patient_triage_bindings.dart';
import 'package:psicApp/app/presentation/modules/patient/triage/patient_triage_view.dart';
import 'package:psicApp/app/presentation/modules/patient/psychologist_selector/psychologist_selector_bindings.dart';
import 'package:psicApp/app/presentation/modules/patient/psychologist_selector/psychologist_selector_view.dart';
import 'package:psicApp/app/presentation/modules/user_profile/user_profile_bindings.dart';
import 'package:psicApp/app/presentation/modules/user_profile/user_profile_view.dart';
import 'package:psicApp/app/presentation/routes/app_routes.dart';
import 'package:psicApp/app/presentation/modules/auth/gate/auth_gate.dart';
import 'package:psicApp/app/presentation/modules/auth/gate/auth_state_widget.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.initial, page: () => const AuthGate()),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.select_role,
      page: () => SelectRoleView(),
      binding: SelectRoleBindings(),
    ),
    GetPage(
      name: AppRoutes.register_user,
      page: () => RegisterUserView(),
      binding: RegisterUserBindings(),
    ),
    GetPage(
      name: AppRoutes.user_profile,
      page: () => UserProfileView(),
      binding: UserProfileBindings(),
    ),
    GetPage(
      name: AppRoutes.patient_triage,
      page: () => PatientTriageView(),
      binding: PatientTriageBindings(),
    ),
    GetPage(
      name: AppRoutes.psychologist_selector,
      page: () => PsychologistSelectorView(),
      binding: PsychologistSelectorBindings(),
    ),
    GetPage(
      name: AppRoutes.timeSlot_selector,
      page: () => TimeSlotSelectorView(),
      binding: TimeSlotSelectorBindings(),
    ),
    GetPage(
      name: AppRoutes.agenda,
      page: () => AgendaView(),
      binding: AgendaBindings(),
    ),
    GetPage(name: AppRoutes.home, page: () => AuthStateWidget()),
  ];
}
