import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/auth_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _passwordController = TextEditingController();
  late String _jenisKelamin;
  File? _image;
  bool _isLoading = false;

  final storage = const FlutterSecureStorage();
  final picker = ImagePicker();
  late final authService = AuthService(createDioClient());

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _jenisKelamin = widget.user.jenisKelamin ?? 'L';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final token = await storage.read(key: 'token');
      if (token == null) throw Exception('Token tidak ditemukan.');
      final authHeader = 'Bearer $token';

      // 1. Update Profile Photo if selected
      if (_image != null) {
        final bytes = await _image!.readAsBytes();
        final base64Image = "data:image/png;base64,${base64Encode(bytes)}";
        await authService.updateProfilePhoto(
            authHeader, {"profile_photo": base64Image});
      }

      // 2. Update Profile Data
      final body = {
        "name": _nameController.text,
        "email": _emailController.text,
        "jenis_kelamin": _jenisKelamin,
      };

      if (_passwordController.text.isNotEmpty) {
        body["password"] = _passwordController.text;
      }

      final response = await authService.updateProfile(authHeader, body);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Profil berhasil diperbarui')),
        );
        // Pop and return true to refresh ProfileScreen
        Navigator.pop(context, true);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (widget.user.profilePhoto != null && widget.user.profilePhoto!.isNotEmpty)
                              ? NetworkImage(widget.user.profilePhoto!) as ImageProvider
                              : null,
                      child: (_image == null && (widget.user.profilePhoto == null || widget.user.profilePhoto!.isEmpty))
                          ? const Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email wajib diisi';
                  if (!value.contains('@')) return 'Format email tidak valid';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password (Opsional)', 
                    border: OutlineInputBorder(),
                    helperText: 'Isi jika ingin mengubah password'
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _jenisKelamin,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updateProfile,
                  child: _isLoading ? const CircularProgressIndicator() : const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
