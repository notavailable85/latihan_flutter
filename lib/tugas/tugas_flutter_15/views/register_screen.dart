import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/auth_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/home_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/login_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/widgets/glassmorphism_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _jenisKelamin = 'L';
  File? _image;
  bool _isLoading = false;

  final storage = const FlutterSecureStorage();
  final picker = ImagePicker();
  late final authService = AuthService(createDioClient());

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      String? base64Image;
      if (_image != null) {
        final bytes = await _image!.readAsBytes();
        base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      }

      final body = {
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "jenis_kelamin": _jenisKelamin,
        "batch_id": 1,
        "training_id": 1,
      };

      if (base64Image != null) {
        body["profile_photo"] = base64Image;
      }

      final response = await authService.register(body);

      if (response.data?.token != null) {
        await storage.write(key: 'token', value: response.data!.token!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'Registrasi berhasil')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi gagal, token tidak didapatkan.')),
          );
        }
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.response?.data?['message'] ?? e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GlassBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 100.0, bottom: 24.0),
            child: GlassContainer(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GlassTextField(
                      controller: _nameController,
                      labelText: 'Name',
                      prefixIcon: Icons.person_outline,
                      validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    GlassTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Email wajib diisi';
                        if (!value.contains('@')) return 'Format email tidak valid';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GlassTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? 'Password wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _jenisKelamin,
                      dropdownColor: const Color(0xFFE94057),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(Icons.people_outline, color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                        DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _jenisKelamin = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: GlassButton(
                        onPressed: _isLoading ? null : _register,
                        isLoading: _isLoading,
                        child: const Text('Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Sudah punya akun? Login di sini',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
