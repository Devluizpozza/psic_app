import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/db/collections_ref.dart';
import 'package:psicApp/app/db/db.dart';
import 'package:psicApp/app/models/psychologist_model.dart';
import 'package:psicApp/app/utils/logger.dart';

class PsychologistRepository extends DB {
  PsychologistRepository();

  Future<Psychologist> fetch(String uid) async {
    try {
      DocumentSnapshot<Psychologist> doc =
          await CollectionsRef.psychologist.doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return Psychologist.empty();
      }

      return doc.data()!;
    } catch (e) {
      Logger.info(e);
      return Future.error("Erro ao buscar psicólogo: $e");
    }
  }

  Future<List<Psychologist>> list() async {
    try {
      final query = await CollectionsRef.psychologist.get();

      return query.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Logger.info(e);
      return [];
    }
  }

  Future<bool> create(Psychologist psychologist) async {
    try {
      await CollectionsRef.psychologist.doc(psychologist.uid).set(psychologist);
      return true;
    } catch (e) {
      Logger.info(e.toString());
      return false;
    }
  }

  Future<bool> updateOnly(String uid, Map<String, dynamic> changes) async {
    try {
      await CollectionsRef.psychologist.doc(uid).update(changes);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }
}
