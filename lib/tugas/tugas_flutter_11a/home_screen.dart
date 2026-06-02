import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/preference_handler.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(BuildContext context) async {
    // Hapus status login
    await PreferenceHandler.setLogin(false);

    // Kembali ke login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen(isLogout: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),

        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: const Center(
        child: Text(
          'Selamat Datang!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
