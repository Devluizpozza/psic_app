// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:psicApp/app/utils/logger.dart';
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

  //   function hyphensToCamelCase(str) {
  //     var arr = str.split(/[_-]/);
  //     var newStr = "";
  //     for (var i = 1; i < arr.length; i++) {
  //         newStr += arr[i].charAt(0).toUpperCase() + arr[i].slice(1);
  //     }
  //     return arr[0] + newStr;
  // }

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

  // static String encrypt(String text, {String secretKey = Consts.key}) {
  //   try {
  //     final key = Key.fromUtf8(secretKey);
  //     final iv = IV.fromUtf8(secretKey);
  //     final encrypter = Encrypter(AES(key));
  //     final encrypted = encrypter.encrypt(text, iv: iv);
  //     return encrypted.base64;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  // static String decrypt(String encryptedText, {String secretKey = Consts.key}) {
  //   try {
  //     final key = Key.fromUtf8(secretKey);
  //     final iv = IV.fromUtf8(secretKey);
  //     final encrypted = Encrypted.fromBase64(encryptedText);
  //     final encrypter = Encrypter(AES(key));
  //     final decrypted = encrypter.decrypt(encrypted, iv: iv);
  //     return decrypted;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  // Map<String, dynamic> firebaseOptionsFromJson() {
  //   FirebaseOptions firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  //   return {
  //     'apiKey': firebaseOptions.apiKey,
  //     'appId': firebaseOptions.appId,
  //     'messagingSenderId': firebaseOptions.messagingSenderId,
  //     'projectId': firebaseOptions.projectId,
  //     'databaseURL': firebaseOptions.databaseURL,
  //     'storageBucket': firebaseOptions.storageBucket,
  //     'androidClientId': firebaseOptions.androidClientId,
  //     'iosClientId': firebaseOptions.iosClientId,
  //     'iosBundleId': firebaseOptions.iosBundleId,
  //   };
  // }

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

  // static String getLocalTimezoneName() =>
  //     tz.TZDateTime.from(
  //       DateTime.now(),
  //       tz.getLocation('America/Sao_Paulo'),
  //     ).timeZoneName;

  // static String httpProtocol(String value) {
  //   if (AppRegex.httpProtocolChecker.hasMatch(value)) {
  //     return value;
  //   }
  //   return "https://$value";
  // }
}
