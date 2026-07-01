import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/auth_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/edit_profile_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/login_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/widgets/glassmorphism_widgets.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: GlassBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : _errorMsg != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_errorMsg!, style: const TextStyle(color: Colors.redAccent)),
                        const SizedBox(height: 16),
                        GlassButton(
                          onPressed: _fetchProfile,
                          child: const Text('Coba Lagi', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _logout,
                          child: const Text('Ke Halaman Login', style: TextStyle(color: Colors.white70)),
                        )
                      ],
                    ),
                  )
                : _user == null
                    ? const Center(child: Text('Data profil tidak tersedia.', style: TextStyle(color: Colors.white)))
                    : RefreshIndicator(
                        onRefresh: _fetchProfile,
                        color: Colors.white,
                        backgroundColor: Colors.pinkAccent,
                        child: ListView(
                          padding: const EdgeInsets.only(top: 100.0, bottom: 100.0, left: 16.0, right: 16.0),
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white.withOpacity(0.2),
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
                            GlassContainer(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: const Icon(Icons.person, color: Colors.white),
                                title: const Text('Nama', style: TextStyle(color: Colors.white70)),
                                subtitle: Text(_user!.name ?? '-', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),
                            GlassContainer(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: const Icon(Icons.email, color: Colors.white),
                                title: const Text('Email', style: TextStyle(color: Colors.white70)),
                                subtitle: Text(_user!.email ?? '-', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),
                            GlassContainer(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: const Icon(Icons.transgender, color: Colors.white),
                                title: const Text('Jenis Kelamin', style: TextStyle(color: Colors.white70)),
                                subtitle: Text(_user!.jenisKelamin == 'L'
                                    ? 'Laki-laki'
                                    : _user!.jenisKelamin == 'P'
                                        ? 'Perempuan'
                                        : '-', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
      floatingActionButton: _user != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white.withOpacity(0.3),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
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
                child: const Icon(Icons.edit, color: Colors.white),
              ),
            )
          : null,
    );
  }
}
