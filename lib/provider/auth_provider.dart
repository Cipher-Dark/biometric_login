import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isBioAuth = false;
  bool _enableBiometric = false;

  AuthProvider() {
    loadPreferences();
  }

  bool get getBioAuth => _isBioAuth;
  bool get getEnableBio => _enableBiometric;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _enableBiometric = prefs.getBool('onBioAuth') ?? false;

    notifyListeners();
  }

  Future<void> toggleBioAuth() async {
    // final pref = await SharedPreferences.getInstance();
    // await pref.setBool("bioAuth", !_isBioAuth);
    _isBioAuth = !_isBioAuth;
    notifyListeners();
  }

  Future<void> toggleEnableBio() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBioAuth', !_enableBiometric);
    _enableBiometric = !_enableBiometric;

    notifyListeners();
  }
}
