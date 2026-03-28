import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;
  late FlutterSecureStorage _secureStorage;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
    return this;
  }

  // Token Methods
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: AppConstants.TOKEN_KEY, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: AppConstants.TOKEN_KEY);
  }

  Future<void> removeToken() async {
    await _secureStorage.delete(key: AppConstants.TOKEN_KEY);
  }

  // User Methods
  Future<void> saveUser(Map<String, dynamic> user) async {
    final String userJson = jsonEncode(user);
    await _prefs.setString(AppConstants.USER_KEY, userJson);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final String? userJson = _prefs.getString(AppConstants.USER_KEY);
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  Future<String?> getUserRole() async {
    final Map<String, dynamic>? user = await getUser();
    return user?['role']; // Assuming 'role' key exists in the user map
  }

  // Clear All
  Future<void> clearAll() async {
    await _prefs.clear();
    await _secureStorage.deleteAll();
  }
}
