import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/screens/onboarding_page.dart';
import 'package:latihan_flutter/safenesia/additional/shared_preference.dart';
import 'package:latihan_flutter/safenesia/screens/home_page.dart';
import 'package:latihan_flutter/safenesia/screens/login_page.dart';

class SnSplashScreenPage extends StatefulWidget {
  const SnSplashScreenPage({super.key});

  @override
  State<SnSplashScreenPage> createState() => _SnSplashScreenPageState();
}

class _SnSplashScreenPageState extends State<SnSplashScreenPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SnOnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// LOGO
            Container(
              height: 120,
              width: 120,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),

              child: const Icon(Icons.school, size: 70, color: Colors.blue),
            ),

            const SizedBox(height: 25),

            /// APP NAME
            const Text(
              "Aplikasi Pelatihan",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            /// SUBTITLE
            const Text(
              "Belajar Lebih Mudah & Profesional",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 40),

            /// LOADING
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
