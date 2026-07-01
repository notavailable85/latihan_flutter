import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/user_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/widgets/glassmorphism_widgets.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final userService = UserService(createDioClient());
  List<User> _users = [];
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await userService.getUsers();
      if (mounted) {
        setState(() {
          _users = response.data ?? [];
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _errorMsg = 'Error: ${e.response?.data?['message'] ?? e.message}';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMsg = 'Error: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Daftar Pengguna', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GlassBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : _errorMsg != null
                ? Center(child: Text(_errorMsg!, style: const TextStyle(color: Colors.redAccent)))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 100, bottom: 100, left: 16, right: 16),
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return GlassContainer(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: user.profilePhoto != null ? NetworkImage(user.profilePhoto!) : null,
                            child: user.profilePhoto == null ? const Icon(Icons.person, color: Colors.white) : null,
                          ),
                          title: Text(user.name ?? '-', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(user.email ?? '-', style: const TextStyle(color: Colors.white70)),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
