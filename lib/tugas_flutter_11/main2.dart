import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas_flutter_11/preference_handler.dart';
import 'package:latihan_flutter/tugas_flutter_11/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi SharedPreferences
  await PreferenceHandler.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Session App',
      home: const SplashScreen(),
    );
  }
}
