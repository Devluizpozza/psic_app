import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';

class AppUser extends Equatable {
  final String uid;
  final String name;
  final String contato;
  final String email;
  final String imageUrl;
  final UserRoleType userType;
  final DateTime createAt;
  final OnboardingStepType onboardingStepType;

  const AppUser({
    required this.uid,
    required this.name,
    required this.contato,
    required this.email,
    this.imageUrl = '',
    required this.userType,
    required this.createAt,
    required this.onboardingStepType,
  });

  String get type => userType.name.toString();
  String get onboardingType => onboardingStepType.name.toString();

  static OnboardingStepType _parseOnboardingType(dynamic value) {
    if (value == null) return OnboardingStepType.none;

    if (value is OnboardingStepType) {
      return value;
    }
    if (value is String) {
      return OnboardingStepType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => OnboardingStepType.none,
      );
    }

    return OnboardingStepType.none;
  }

  static UserRoleType _parseUserType(dynamic value) {
    if (value == null) return UserRoleType.none;

    if (value is UserRoleType) {
      return value;
    }
    if (value is String) {
      return UserRoleType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => UserRoleType.none,
      );
    }

    return UserRoleType.none;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    return DateTime.now();
  }

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contato: map['contato'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      userType: _parseUserType(map['userType']),
      onboardingStepType: _parseOnboardingType(map['onboardingStepType']),
      createAt: _parseDate(map['createAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'contato': contato,
      'email': email,
      'imageUrl': imageUrl,
      'userType': type,
      'createAt': createAt,
      'onboardingStepType': onboardingType,
    };
  }

  factory AppUser.empty() {
    return AppUser(
      uid: '',
      name: '',
      contato: '',
      email: '',
      userType: UserRoleType.none,
      onboardingStepType: OnboardingStepType.none,
      createAt: DateTime.now(),
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contato: map['contato'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      userType: _parseUserType(map['userType']),
      onboardingStepType: _parseOnboardingType(map['onboardingStepType']),
      createAt:
          (map['createAt'] is Timestamp)
              ? (map['createAt'] as Timestamp).toDate()
              : DateTime.tryParse(map['createAt']?.toString() ?? '') ??
                  DateTime.now(),
    );
  }

  AppUser copyWith(Map<String, dynamic> newer) {
    Map<String, dynamic> current = toJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return AppUser.fromJson(merged);
  }

  @override
  List<Object?> get props => [
    uid,
    name,
    contato,
    email,
    imageUrl,
    type,
    onboardingType,
    createAt,
  ];
}
