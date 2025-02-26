import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final bool _bioAuth = false;

  bool getBioAuth() => _bioAuth;
}
