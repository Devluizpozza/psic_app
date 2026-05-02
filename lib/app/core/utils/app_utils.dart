// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:psicApp/app/core/logger/logger.dart';
import 'package:uuid/uuid.dart';

abstract class AppUtils {
  static String generateUUID() {
    Uuid uuid = const Uuid();
    String key = uuid.v4();
    return key;
  }

  static String getFileExtension(String filename) {
    return path.extension(filename).replaceFirst(".", "");
  }

  static String underScoreToCamelCase(String value) {
    try {
      RegExp exp = RegExp(r'\_[a-z]');
      return value.replaceAllMapped(exp, (Match m) {
        String letter = m.group(0).toString().toUpperCase().substring(1, 2);
        return letter;
      });
    } catch (e) {
      return value;
    }
  }

  static String onlyDigits(String value) {
    return value.replaceAll(RegExp('[^0-9]'), '');
  }

  static String randomDigits({int digits = 6}) {
    Random random = Random.secure();
    double next = random.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt().toString();
  }

  static Future<File?> getFileFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final File file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );

      return file;
    } catch (e) {
      Logger.info(e);
      return null;
    }
  }

  static bool canIphoneNumberLocalFormat(String phoneNumber) =>
      RegExp(r'/^\d{1}\s|^\d{2}\s|^\d{3}\s|^\d{4}\s').hasMatch(phoneNumber);

  static String formatPhoneNumberLocal(String phoneNumber) {
    if (AppUtils.canIphoneNumberLocalFormat(phoneNumber)) {
      RegExpMatch? matched = RegExp(r'\s').firstMatch(phoneNumber);

      if (matched != null) {
        String ddd = phoneNumber.substring(0, matched.start);
        return phoneNumber.replaceFirst(ddd, '($ddd)');
      }
      return phoneNumber;
    }
    return phoneNumber;
  }

  static Future<String> getClipBoardData() async {
    try {
      ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      return data?.text ?? "";
    } catch (e) {
      return "";
    }
  }

  static List<int> generateAmount({
    int min = 8,
    int max = 32,
    List<int> list = const <int>[],
  }) {
    list = list.isEmpty && min % 2 == 0 ? [min] : list;
    int value = min * 2;
    if (value <= max) {
      list.add(value);
      return generateAmount(min: value, max: max, list: list);
    }
    return list;
  }

  static isRed(Color color) =>
      color.computeLuminance() > 0.100 && color.computeLuminance() < 0.300;

  static isWhite(Color color) =>
      color.computeLuminance() > 0.89 && color.computeLuminance() <= 1.0;

  static DateTime remoteToDateTime(dynamic date) {
    try {
      if (date == null) {
        return DateTime(0);
      }
      return DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
    } on NoSuchMethodError catch (_) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    }
  }
}
