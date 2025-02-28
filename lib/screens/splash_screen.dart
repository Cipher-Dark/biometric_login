import 'package:biometric_login/auth/bio_auth.dart';
import 'package:biometric_login/provider/auth_provider.dart';
import 'package:biometric_login/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        final authProvider = context.read<AuthProvider>();

        await authProvider.loadPreferences();
        if (authProvider.getEnableBio) {
          final getBio = await BioAuth().setBiometric(context);

          if (getBio) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Home()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Home()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 225, 250),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/lock.png",
              scale: 3,
            ),
            InkWell(
              onTap: () {
                final authProvider = context.read<AuthProvider>();

                BioAuth().setBiometric(context).then((_) {
                  if (authProvider.getBioAuth) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Home()),
                    );
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text("Unlock"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
