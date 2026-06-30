import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/auth_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/edit_profile_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = const FlutterSecureStorage();
  late final authService = AuthService(createDioClient());
  User? _user;
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        throw Exception('Token tidak ditemukan, harap login kembali.');
      }

      final response = await authService.getProfile('Bearer $token');
      if (response.data != null) {
        setState(() {
          _user = response.data;
        });
      } else {
        setState(() {
          _errorMsg = response.message ?? 'Gagal memuat profil.';
        });
      }
    } on DioException catch (e) {
      setState(() {
        _errorMsg = 'Error: ${e.response?.data?['message'] ?? e.message}';
      });
    } catch (e) {
      setState(() {
        _errorMsg = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await storage.delete(key: 'token');
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMsg != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMsg!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchProfile,
                        child: const Text('Coba Lagi'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _logout,
                        child: const Text('Ke Halaman Login'),
                      )
                    ],
                  ),
                )
              : _user == null
                  ? const Center(child: Text('Data profil tidak tersedia.'))
                  : RefreshIndicator(
                      onRefresh: _fetchProfile,
                      child: ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: _user!.profilePhoto != null &&
                                      _user!.profilePhoto!.isNotEmpty
                                  ? NetworkImage(_user!.profilePhoto!)
                                  : null,
                              child: _user!.profilePhoto == null ||
                                      _user!.profilePhoto!.isEmpty
                                  ? const Icon(Icons.person,
                                      size: 60, color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Nama'),
                              subtitle: Text(_user!.name ?? '-'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text('Email'),
                              subtitle: Text(_user!.email ?? '-'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.transgender),
                              title: const Text('Jenis Kelamin'),
                              subtitle: Text(_user!.jenisKelamin == 'L'
                                  ? 'Laki-laki'
                                  : _user!.jenisKelamin == 'P'
                                      ? 'Perempuan'
                                      : '-'),
                            ),
                          ),
                        ],
                      ),
                    ),
      floatingActionButton: _user != null
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(user: _user!),
                  ),
                );
                if (result == true) {
                  _fetchProfile();
                }
              },
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}
