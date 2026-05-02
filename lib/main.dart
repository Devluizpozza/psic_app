import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:psicApp/app/app_widget.dart';
import 'package:psicApp/app/data/services/geo_location_service.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('pt_BR');

  Get.put(UserController());
  Get.put(GeolocationService());
  runApp(AppWidget());
}
// abel