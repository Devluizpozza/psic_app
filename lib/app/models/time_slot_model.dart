import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSlot {
  final String uid;
  final String psychologistId;
  final DateTime startAt;
  final DateTime endAt;
  final bool isAvailable;
  final String? patientId;

  TimeSlot({
    required this.uid,
    required this.psychologistId,
    required this.startAt,
    required this.endAt,
    required this.isAvailable,
    this.patientId,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> map) {
    return TimeSlot(
      uid: map['uid'] ?? '',
      psychologistId: map['psychologistId'] ?? '',
      startAt: (map['startAt'] as Timestamp).toDate(),
      endAt: (map['endAt'] as Timestamp).toDate(),
      isAvailable: map['isAvailable'] ?? false,
      patientId: map['patientId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'psychologistId': psychologistId,
      'startAt': startAt,
      'endAt': endAt,
      'isAvailable': isAvailable,
      'patientId': patientId,
    };
  }

  factory TimeSlot.empty() {
    return TimeSlot(
      uid: '',
      psychologistId: '',
      startAt: DateTime.now(),
      endAt: DateTime.now(),
      isAvailable: false,
      patientId: '',
    );
  }

  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      uid: map['uid'] ?? '',
      psychologistId: map['psychologistId'] ?? '',
      startAt: (map['startAt'] as Timestamp).toDate(),
      endAt: (map['endAt'] as Timestamp).toDate(),
      isAvailable: map['isAvailable'] ?? false,
      patientId: map['patientId'] ?? '',
    );
  }

  TimeSlot copyWith(Map<String, dynamic> newer) {
    Map<String, dynamic> current = toJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return TimeSlot.fromJson(merged);
  }

  @override
  List<Object?> get props => [
    uid,
    psychologistId,
    startAt,
    endAt,
    isAvailable,
    patientId,
  ];
}
