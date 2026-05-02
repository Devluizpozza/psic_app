import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/data/datasources/firestore/collections.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/domain/models/log.dart';
import 'package:psicApp/app/domain/models/patient.dart';
import 'package:psicApp/app/domain/models/psychologist.dart';
import 'package:psicApp/app/domain/models/schedule.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';

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

        static CollectionReference<Patient> get patient => DB.firestoreInstance
      .collection(Collections.patient)
      .withConverter<Patient>(
        fromFirestore: (snapshot, _) {
          return Patient.fromJson(snapshot.data()!);
        },
        toFirestore: (Patient patient, _) {
          return patient.toJson();
        },
      );
}
