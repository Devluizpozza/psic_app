import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/db/collections.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/models/app_user_model.dart';
import 'package:psicApp/app/models/log_model.dart';
import 'package:psicApp/app/models/psychologist_model.dart';
import 'package:psicApp/app/models/schedule_model.dart';
import 'package:psicApp/app/models/time_slot_model.dart';

abstract class CollectionsRef {
  static CollectionReference get initialValue =>
      DB.firestoreInstance.collection(Collections.initial_value);

  static CollectionReference<AppUser> get appUser => DB.firestoreInstance
      .collection(Collections.app_user)
      .withConverter<AppUser>(
        fromFirestore: (snapshot, _) {
          return AppUser.fromJson(snapshot.data()!);
        },
        toFirestore: (AppUser appUser, _) {
          return appUser.toJson();
        },
      );

  static CollectionReference<Log> get log => DB.firestoreInstance
      .collection(Collections.log)
      .withConverter<Log>(
        fromFirestore: (snapshot, _) {
          return Log.fromJson(snapshot.data()!);
        },
        toFirestore: (Log log, _) {
          return log.toJson();
        },
      );
  static CollectionReference<Psychologist> get psychologist => DB
      .firestoreInstance
      .collection(Collections.psychologist)
      .withConverter<Psychologist>(
        fromFirestore: (snapshot, _) {
          return Psychologist.fromJson(snapshot.data()!);
        },
        toFirestore: (Psychologist psychologist, _) {
          return psychologist.toJson();
        },
      );

  static CollectionReference<TimeSlot> timeSlot(psychologistId) => DB
      .firestoreInstance
      .collection(Collections.psychologist)
      .doc(psychologistId)
      .collection(Collections.time_slot)
      .withConverter<TimeSlot>(
        fromFirestore: (snapshot, _) {
          return TimeSlot.fromJson(snapshot.data()!);
        },
        toFirestore: (TimeSlot timeSlot, _) {
          return timeSlot.toJson();
        },
      );

  static CollectionReference<Schedule> get schedule => DB.firestoreInstance
      .collection(Collections.schedule)
      .withConverter<Schedule>(
        fromFirestore: (snapshot, _) {
          return Schedule.fromJson(snapshot.data()!);
        },
        toFirestore: (Schedule timeSlot, _) {
          return timeSlot.toJson();
        },
      );
}
