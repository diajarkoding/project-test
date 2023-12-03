import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataStore {
  static const boxName = 'initBox';
  static const keyName = 'isFirstInstall';
  static const secureBoxName = 'projectTestSecureBox';
  static const secureKeyName = 'projectTestSecureKey';
  static const userIdKey = 'user_id';
  static const isLoginKey = 'login_key';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<bool>(boxName);
  }

// {required String pin, required String email}
  Future<void> initSecureBox() async {
    const secureStorage = FlutterSecureStorage();
    String? encryptedKey = await secureStorage.read(key: secureKeyName);
    if (encryptedKey == null) {
      final securekey = Hive.generateSecureKey();
      await secureStorage.write(
        key: secureKeyName,
        value: base64UrlEncode(securekey),
      );
      encryptedKey = await secureStorage.read(key: secureKeyName);
    }
    final chiperKey = base64Url.decode(encryptedKey!);
    await Hive.openBox(
      secureBoxName,
      encryptionCipher: HiveAesCipher(chiperKey),
    );
  }

  Future<void> setHiveBox() async {
    final box = Hive.box<bool>(boxName);
    if (box.isEmpty) {
      await box.put(keyName, true);
    }
  }

// TOKEN
  void saveLogin(bool? isLogin) {
    final isLoginBox = Hive.box(secureBoxName);
    if ((isLogin ?? false)) {
      isLoginBox.put(isLoginKey, isLogin);
      debugPrint('=== store isLogin success ===');
    }
  }

  bool? getLogin() {
    final isLoginBox = Hive.box(secureBoxName);
    final bool? isLogin = isLoginBox.get(isLoginKey);
    if ((isLogin ?? false)) {
      return false;
    }
    return isLogin;
  }

  void clearLogin() {
    final isLoginBox = Hive.box(secureBoxName);
    isLoginBox.delete(isLoginKey);
  }

// TOKEN
  void saveUserId(String? userId) {
    final userIdBox = Hive.box(secureBoxName);
    if ((userId ?? '').isNotEmpty) {
      userIdBox.put(userIdKey, userId);
      debugPrint('=== store userId success ===');
    }
  }

  String? getUserId() {
    final userIdBox = Hive.box(secureBoxName);
    final String? userId = userIdBox.get(userIdKey);
    if ((userId ?? '').isEmpty) {
      return '';
    }
    return userId;
  }

  void clearUserId() {
    final userIdBox = Hive.box(secureBoxName);
    userIdBox.delete(userIdKey);
  }
}
