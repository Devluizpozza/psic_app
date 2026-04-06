// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:psicApp/app/core/utils/app_utils.dart';

class EventDateTime extends Equatable {
  final DateTime startAt;
  final DateTime endAt;
  final String timeZone;
  final DateTime createdAt;
  final bool disabled;
  final bool weekly;
  final int weekday;

  const EventDateTime({
    required this.startAt,
    required this.endAt,
    required this.timeZone,
    required this.createdAt,
    this.disabled = false,
    this.weekly = false,
    this.weekday = 1,
  });

  bool get startActived => startAt.compareTo(createdAt) == -1;

  bool get endActived => endAt.compareTo(createdAt) == -1;

  bool get isEndOutOfTime => DateTime.now().isAfter(endAt);

  factory EventDateTime.fromJson(Map<String, dynamic> map) {
    return EventDateTime(
      startAt: AppUtils.remoteToDateTime(map["startAt"]),
      endAt: AppUtils.remoteToDateTime(map["endAt"]),

      timeZone: map['timeZone'],
      createdAt: AppUtils.remoteToDateTime(map["createdAt"]),
      disabled: map['disabled'] ?? false,
      weekly: map['weekly'] ?? false,
      weekday: map['weekday'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startAt': startAt,
      'endAt': endAt,

      'timeZone': timeZone,
      'createdAt': createdAt,
      'disabled': disabled,
      'weekly': weekly,
      'weekday': weekday,
    };
  }

  factory EventDateTime.fromRealtimeJson(Map<String, dynamic> map) {
    return EventDateTime(
      startAt: AppUtils.remoteToDateTime(map['startAt']),
      endAt: AppUtils.remoteToDateTime(map['endAt']),

      timeZone: map['timeZone'],
      createdAt: AppUtils.remoteToDateTime(map["createdAt"]),
      disabled: map['disabled'] ?? false,
      weekly: map['weekly'] ?? false,
      weekday: map['weekday'] ?? 1,
    );
  }

  Map<String, dynamic> toRealtimeJson() {
    return {
      'startAt': startAt.millisecondsSinceEpoch,
      'endAt': endAt.millisecondsSinceEpoch,

      'timeZone': timeZone,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'disabled': disabled,
      'weekly': weekly,
      'weekday': weekday,
    };
  }

  factory EventDateTime.empty() => EventDateTime(
    startAt: DateTime.now(),
    endAt: DateTime.now(),

    createdAt: DateTime.now(),
    timeZone: '',
    disabled: true,
  );

  EventDateTime copyWith(Map<String, dynamic> newer, {bool isRDB = false}) {
    Map<String, dynamic> current = !isRDB ? toJson() : toRealtimeJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return !isRDB
        ? EventDateTime.fromJson(merged)
        : EventDateTime.fromRealtimeJson(merged);
  }

  @override
  List<Object?> get props => [
    startAt,
    endAt,

    timeZone,
    createdAt,
    disabled,
    weekly,
    weekday,
  ];
}
