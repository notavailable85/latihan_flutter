import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// // =====================================
// // MAIN APP
// // =====================================

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Form Pendaftaran',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const RegisterPage(),
//     );
//   }
// }

// =====================================
// HALAMAN REGISTER
// =====================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Global Key Form
  final _formKey = GlobalKey<FormState>();

  // Controller
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();

  // =====================================
  // FUNCTION DIALOG
  // =====================================

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama : ${namaController.text}'),
              Text('Email : ${emailController.text}'),
              Text('No HP : ${hpController.text}'),
              Text('Kota : ${kotaController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                // Navigasi ke halaman konfirmasi
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      nama: namaController.text,
                      kota: kotaController.text,
                    ),
                  ),
                );
              },
              child: const Text('Lanjut'),
            ),
          ],
        );
      },
    );
  }

  // =====================================
  // UI
  // =====================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pendaftaran'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // =====================================
              // NAMA
              // =====================================
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // =====================================
              // EMAIL
              // =====================================
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }

                  if (!value.contains('@')) {
                    return 'Email harus mengandung @';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // =====================================
              // NOMOR HP
              // =====================================
              TextFormField(
                controller: hpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // =====================================
              // KOTA
              // =====================================
              TextFormField(
                controller: kotaController,
                decoration: const InputDecoration(
                  labelText: 'Kota Asal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kota asal wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // =====================================
              // BUTTON
              // =====================================
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Validasi Form
                    if (_formKey.currentState!.validate()) {
                      showConfirmDialog();
                    }
                  },
                  child: const Text('Daftar', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================
// HALAMAN KONFIRMASI
// =====================================

class ConfirmationPage extends StatelessWidget {
  final String nama;
  final String kota;

  const ConfirmationPage({super.key, required this.nama, required this.kota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Terima kasih, $nama dari $kota telah mendaftar.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
