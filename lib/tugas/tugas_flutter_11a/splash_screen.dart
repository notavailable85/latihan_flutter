import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/preference_handler.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/home_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    // Delay 2 detik
    await Future.delayed(const Duration(seconds: 2));

    bool isLogin = PreferenceHandler.isLogin;

    if (isLogin) {
      // Jika sudah login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // Jika belum login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.lock_person, size: 100, color: Colors.blue),

            SizedBox(height: 20),

            Text(
              'Session App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
