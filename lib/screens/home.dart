import 'package:biometric_login/auth/bio_auth.dart';
import 'package:biometric_login/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text("Home"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Enable Biometric Auth"),
                  Consumer<AuthProvider>(
                    builder: (ctx, provider, __) {
                      return Switch.adaptive(
                        value: provider.getEnableBio,
                        onChanged: (value) async {
                          bool isAuthenticated = await BioAuth().setBiometric(context);
                          if (isAuthenticated) {
                            provider.toggleEnableBio();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  "Biometric authentication is ${!provider.getEnableBio ? "Enabled" : "Disabled"}",
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
