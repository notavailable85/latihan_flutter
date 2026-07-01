import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/training_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/widgets/glassmorphism_widgets.dart';

class TrainingDetailScreen extends StatefulWidget {
  final int id;
  const TrainingDetailScreen({super.key, required this.id});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  final trainingService = TrainingService(createDioClient());
  final storage = const FlutterSecureStorage();
  Training? _training;
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    try {
      final token = await storage.read(key: 'token') ?? '';
      // Interceptor already handles Bearer token, but we pass it anyway due to method signature
      final response = await trainingService.getTrainingDetail(widget.id, 'Bearer $token');
      if (mounted) {
        setState(() {
          _training = response.data;
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
        title: const Text('Detail Pelatihan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlassBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : _errorMsg != null
                ? Center(child: Text(_errorMsg!, style: const TextStyle(color: Colors.redAccent)))
                : _training == null
                    ? const Center(child: Text('Data tidak ditemukan', style: TextStyle(color: Colors.white)))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 100, bottom: 24, left: 16, right: 16),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_training!.title ?? 'Tidak ada judul', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                              const SizedBox(height: 24),
                              _buildDetailRow(Icons.description, 'Deskripsi', _training!.description ?? '-'),
                              const SizedBox(height: 16),
                              _buildDetailRow(Icons.verified, 'Standar', _training!.standard ?? '-'),
                              const SizedBox(height: 16),
                              _buildDetailRow(Icons.timer, 'Durasi', _training!.duration ?? '-'),
                              const SizedBox(height: 16),
                              _buildDetailRow(Icons.people, 'Jumlah Peserta', _training!.participantCount?.toString() ?? '-'),
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
