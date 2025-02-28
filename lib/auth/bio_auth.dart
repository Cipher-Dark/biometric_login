import 'dart:developer';

import 'package:biometric_login/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:provider/provider.dart';

class BioAuth {
  // late bool _isBioAvailable;

  // void chekBiometric() async {
  //   final LocalAuthentication auth = LocalAuthentication();
  //   final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  //   final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  //   _isBioAvailable = canAuthenticate;
  // }

  Future<bool> setBiometric(BuildContext context) async {
    try {
      final LocalAuthentication auth = LocalAuthentication();

      final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to use this applicaiton', options: const AuthenticationOptions(useErrorDialogs: false));
      if (didAuthenticate) {
        if (context.mounted) {
          context.read<AuthProvider>().toggleBioAuth();
          return didAuthenticate;
        }
      }
      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        log(e.code);
      } else if (e.code == auth_error.notEnrolled) {
        log(e.code);
      } else {
        log(e.code);
      }
      return false;
    }
  }
}
