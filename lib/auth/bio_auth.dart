import 'dart:developer';

import 'package:biometric_login/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:provider/provider.dart';

class BioAuth {
  Future<bool> chekBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> setBiometric(BuildContext context) async {
    final provider = context.read<AuthProvider>();
    try {
      final LocalAuthentication auth = LocalAuthentication();

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to use this applicaiton',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
        ),
      );
      if (didAuthenticate) {
        if (context.mounted) {
          provider.toggleBioAuth();
          return didAuthenticate;
        }
      }
      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        log("This code  ${e.code}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Screen Lock is not available or set",
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      } else if (e.code == auth_error.notEnrolled) {
        log(e.code);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Biometric is not set",
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              e.code,
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return false;
    }
  }
}
