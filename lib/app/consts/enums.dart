// ignore_for_file: constant_identifier_names

enum FeelsType { none, bem, neutro, mal }

enum AnxietyType { none, baixo, medio, alto, insuportavel }

enum VehicleType { none, car, motorcycle }

enum StatusType { none, pending, active, desactive }

enum ActionType {
  none,
  vehicle_exit,
  vehicle_entry,
  request_entry,
  request_accepted,
  request_refused,
}

enum SpecialtyType { none, clinico, psicanalista, infatil, familiar }

enum UserRoleType { none, psychologist, patient }

enum ScheduleStatusType { none, scheduled, requested, cancelled }

enum ScheduleType { none, single, recurring }

enum OnboardingStepType {
  none,
  phone_verified,
  role_selected,
  basic_info_completed,
  finished,
}
