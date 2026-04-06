import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/data/datasources/firestore/collections_ref.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/domain/models/schedule.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class ScheduleRepository extends DB {
  ScheduleRepository();

  Future<Schedule> fetch(String uid) async {
    try {
      DocumentSnapshot<Schedule> doc =
          await CollectionsRef.schedule.doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return Schedule.empty();
      }

      return doc.data()!;
    } catch (e) {
      Logger.info(e);
      return Future.error("Erro ao buscar agendamento: $e");
    }
  }

  Future<List<Schedule>> listByPsyId(String psychologistId) async {
    try {
      final query =
          await CollectionsRef.schedule
              .where("psychologistId", isEqualTo: psychologistId)
              .get();

      return query.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Logger.info(e);
      return [];
    }
  }

  Future<bool> create(Schedule schedule) async {
    try {
      await CollectionsRef.schedule.doc(schedule.uid).set(schedule);
      return true;
    } catch (e) {
      Logger.info(e.toString());
      return false;
    }
  }

  Future<bool> updateOnly(String uid, Map<String, dynamic> changes) async {
    try {
      await CollectionsRef.schedule.doc(uid).update(changes);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }

  Future<bool> delete(String scheduleId) async {
    try {
      await CollectionsRef.schedule.doc(scheduleId).delete();
      return true;
    } catch (e) {
      Logger.info(e.toString());
      return false;
    }
  }
}
