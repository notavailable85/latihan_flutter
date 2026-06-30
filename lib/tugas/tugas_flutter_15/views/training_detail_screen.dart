import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/training_service.dart';

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
      appBar: AppBar(title: const Text('Detail Pelatihan')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMsg != null
              ? Center(child: Text(_errorMsg!, style: const TextStyle(color: Colors.red)))
              : _training == null
                  ? const Center(child: Text('Data tidak ditemukan'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_training!.title ?? 'Tidak ada judul', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Text('Deskripsi: ${_training!.description ?? '-'}'),
                          const SizedBox(height: 8),
                          Text('Standar: ${_training!.standard ?? '-'}'),
                          const SizedBox(height: 8),
                          Text('Durasi: ${_training!.duration ?? '-'}'),
                          const SizedBox(height: 8),
                          Text('Jumlah Peserta: ${_training!.participantCount ?? '-'}'),
                        ],
                      ),
                    ),
    );
  }
}
