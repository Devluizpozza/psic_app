import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/data/datasources/firestore/collections_ref.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/domain/models/patient.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class PatientRepository extends DB {
  PatientRepository();

  Future<Patient> fetch(String uid) async {
    try {
      DocumentSnapshot<Patient> doc =
          await CollectionsRef.patient.doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return Patient.empty();
      }

      return doc.data()!;
    } catch (e) {
      Logger.info(e);
      return Future.error("Erro ao buscar paciente: $e");
    }
  }

  Future<List<Patient>> list() async {
    try {
      final query = await CollectionsRef.patient.get();

      return query.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Logger.info(e);
      return [];
    }
  }

  Future<bool> create(Patient patient) async {
    try {
      await CollectionsRef.patient.doc(patient.uid).set(patient);
      return true;
    } catch (e) {
      Logger.info(e.toString());
      return false;
    }
  }

  Future<bool> updateOnly(String uid, Map<String, dynamic> changes) async {
    try {
      await CollectionsRef.patient.doc(uid).update(changes);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }
}
