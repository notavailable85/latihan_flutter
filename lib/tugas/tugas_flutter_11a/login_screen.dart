import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/preference_handler.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_11a/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isLogout;

  const LoginScreen({super.key, this.isLogout = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Tampilkan snackbar logout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isLogout) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Berhasil Logout')));
      }
    });
  }

  void login() async {
    // Simpan status login
    await PreferenceHandler.setLogin(true);

    // Pindah ke Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: login,
                child: const Text('Masuk'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
