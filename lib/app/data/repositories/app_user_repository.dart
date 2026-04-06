import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psicApp/app/data/datasources/firestore/collections.dart';
import 'package:psicApp/app/data/datasources/firestore/collections_ref.dart';
import 'package:psicApp/app/data/datasources/firestore/db.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/core/logger/logger.dart';

class AppUserRepository extends DB {
  AppUserRepository();

  Future<AppUser> fetch(String uid) async {
    try {
      DocumentSnapshot<AppUser> doc =
          await CollectionsRef.appUser.doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return AppUser.empty();
      }

      return doc.data()!;
    } catch (e) {
      Logger.info(e);
      return Future.error("Erro ao buscar usuário: $e");
    }
  }

  Future<bool> create(AppUser appUser) async {
    try {
      await CollectionsRef.appUser.doc(appUser.uid).set(appUser);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }

  Future<bool> update(AppUser appUser) async {
    try {
      await CollectionsRef.appUser.doc(appUser.uid).set(appUser);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }

  Future<bool> updateOnly(String uid, Map<String, dynamic> changes) async {
    try {
      await CollectionsRef.appUser.doc(uid).update(changes);
      return true;
    } catch (e) {
      Logger.info(e);
      return false;
    }
  }

  Future<AppUser?> fetchByPhoneNumber(String phoneNumber) async {
    try {
      final QuerySnapshot querySnapshot =
          await firestore
              .collection(Collections.app_user)
              .where('contato', isEqualTo: phoneNumber)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        final uid = querySnapshot.docs.first.id;
        return AppUser.fromMap(data).copyWith({"uid": uid});
      } else {
        return null;
      }
    } catch (e) {
      Logger.info(e);
      return Future.error("Erro ao buscar usuário: $e");
    }
  }
}
