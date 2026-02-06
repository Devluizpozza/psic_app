import 'package:equatable/equatable.dart';
import 'package:psicApp/app/consts/enums.dart';
import 'package:psicApp/app/models/event_date_time_model.dart';
import 'package:psicApp/app/services/extensions.dart';

class Schedule extends Equatable {
  final String uid;
  final String ownerId;
  final String psychologistId;
  final EventDateTime eventDateTime;
  final ScheduleStatusType statusType;
  final Map<String, dynamic>? metadata;
  final DateTime updatedAt;
  final DateTime createdAt;

  const Schedule({
    required this.uid,
    required this.ownerId,
    required this.psychologistId,
    required this.eventDateTime,
    required this.statusType,
    required this.metadata,
    required this.updatedAt,
    required this.createdAt,
  });

  String get type => statusType.name.toString();

  factory Schedule.fromJson(Map<String, dynamic> map) {
    return Schedule(
      uid: map['uid'] ?? '',
      ownerId: map['ownerId'] ?? '',
      psychologistId: map['psychologistId'] ?? '',
      eventDateTime: EventDateTime.fromJson(map['eventDateTime']),
      statusType: ScheduleStatusType.values.firstWhere(
        (scheduleStatusType) =>
            scheduleStatusType.name.equals(map['statusType']),
      ),
      metadata:
          map["metadata"] != null
              ? Map<String, dynamic>.from(map["metadata"])
              : null,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'].millisecondsSinceEpoch,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'].millisecondsSinceEpoch,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ownerId': ownerId,
      'psychologistId': psychologistId,
      'eventDateTime': eventDateTime.toJson(),
      'statusType': type,
      'metadata': metadata,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory Schedule.empty() {
    return Schedule(
      uid: '',
      ownerId: '',
      psychologistId: '',
      statusType: ScheduleStatusType.none,
      eventDateTime: EventDateTime.empty(),
      metadata: {},
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      uid: map['uid'] ?? '',
      ownerId: map['ownerId'] ?? '',
      psychologistId: map['psychologistId'] ?? '',
      eventDateTime: EventDateTime.fromJson(map['eventDateTime']),
      statusType: ScheduleStatusType.values.firstWhere(
        (scheduleStatusType) =>
            scheduleStatusType.name.equals(map['statusType']),
      ),
      metadata:
          map["metadata"] != null
              ? Map<String, dynamic>.from(map["metadata"])
              : null,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'].millisecondsSinceEpoch,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'].millisecondsSinceEpoch,
      ),
    );
  }

  Schedule copyWith(Map<String, dynamic> newer) {
    Map<String, dynamic> current = toJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return Schedule.fromJson(merged);
  }

  @override
  List<Object?> get props => [
    uid,
    ownerId,
    psychologistId,
    eventDateTime,
    type,
    metadata,
    updatedAt,
    createdAt,
  ];
}
