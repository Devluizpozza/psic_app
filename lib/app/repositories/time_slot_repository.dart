import 'package:psicApp/app/db/collections_group_ref.dart';
import 'package:psicApp/app/db/collections_ref.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/models/time_slot_model.dart';
import 'package:psicApp/app/utils/logger.dart';

class TimeSlotRepository extends DB {
  TimeSlotRepository();

  Future<TimeSlot> fetch(String psychologistId, String uid) async {
    try {
      final doc = await CollectionsRef.timeSlot(psychologistId).doc(uid).get();

      return doc.data()!;
    } catch (e) {
      Logger.info(e);
      return Future.error("Erro ao buscar psicólogo: $e");
    }
  }

  Future<List<TimeSlot>> listByPsychologistId(String psychologistId) async {
    try {
      final query =
          await CollectionsGroupRef.timeSlot
              .where("psychologistId", isEqualTo: psychologistId)
              .orderBy("startAt")
              .get();
      return query.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Logger.info(e.toString());
      return [];
    }
  }

  Future<bool> create(String psychologistId, TimeSlot timeSlot) async {
    try {
      await CollectionsRef.timeSlot(
        psychologistId,
      ).doc(timeSlot.uid).set(timeSlot);
      return true;
    } catch (e) {
      Logger.info(e.toString());
      return false;
    }
  }

  Future<bool> updateOnly(
    String psychologistUID,
    String timeSLotId,
    Map<String, dynamic> changes,
  ) async {
    try {
      await CollectionsRef.timeSlot(
        psychologistUID,
      ).doc(timeSLotId).update(changes);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }
}
