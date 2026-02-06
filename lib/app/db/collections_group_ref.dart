// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/db/collections.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/models/time_slot_model.dart';

abstract class CollectionsGroupRef {
  // static Query<Follower> get follower => DB.firestoreInstance
  //     .collectionGroup(Collections.follower)
  //     .withConverter<Follower>(
  //       fromFirestore: (snapshot, _) {
  //         return Follower.fromJson(snapshot.data()!);
  //       },
  //       toFirestore: (Follower scoreBySport, _) {
  //         return scoreBySport.toJson();
  //       },
  //     );

  // static Query<Ticket> get ticket => DB.firestoreInstance
  //     .collectionGroup(Collections.ticket)
  //     .withConverter<Ticket>(
  //       fromFirestore: (snapshot, _) {
  //         return Ticket.fromJson(snapshot.data()!);
  //       },
  //       toFirestore: (Ticket scoreBySport, _) {
  //         return scoreBySport.toJson();
  //       },
  //     );

  static Query<TimeSlot> get timeSlot => DB.firestoreInstance
      .collectionGroup(Collections.time_slot)
      .withConverter<TimeSlot>(
        fromFirestore: (snapshot, _) {
          return TimeSlot.fromJson(snapshot.data()!);
        },
        toFirestore: (TimeSlot timeSlot, _) {
          return timeSlot.toJson();
        },
      );
}
