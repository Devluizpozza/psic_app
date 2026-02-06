import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/app_widget.dart';
import 'package:psicApp/app/modules/user/user_controller.dart';
import 'package:psicApp/app/services/geo_location_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(UserController());
  Get.put(GeolocationService());
  runApp(AppWidget());
}
