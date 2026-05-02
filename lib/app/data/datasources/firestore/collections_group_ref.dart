import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/data/datasources/firestore/collections.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';

abstract class CollectionsGroupRef {
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
