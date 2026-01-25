import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionaqui/app/db/collections.dart';
import 'package:estacionaqui/app/db/db.dart';
import 'package:estacionaqui/app/models/app_user_model.dart';
import 'package:estacionaqui/app/models/log_model.dart';
import 'package:estacionaqui/app/models/psychologist_model.dart';

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
}
