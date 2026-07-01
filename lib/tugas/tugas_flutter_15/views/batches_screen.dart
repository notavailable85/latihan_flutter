import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/batch_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/widgets/glassmorphism_widgets.dart';

class BatchesScreen extends StatefulWidget {
  const BatchesScreen({super.key});

  @override
  State<BatchesScreen> createState() => _BatchesScreenState();
}

class _BatchesScreenState extends State<BatchesScreen> {
  final batchService = BatchService(createDioClient());
  final storage = const FlutterSecureStorage();
  List<Batch> _batches = [];
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _fetchBatches();
  }

  Future<void> _fetchBatches() async {
    try {
      final token = await storage.read(key: 'token') ?? '';
      final response = await batchService.getBatches('Bearer $token');
      if (mounted) {
        setState(() {
          _batches = response.data ?? [];
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
        title: const Text('Daftar Batch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                    itemCount: _batches.length,
                    itemBuilder: (context, index) {
                      final batch = _batches[index];
                      return GlassContainer(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text('Batch Ke: ${batch.batchKe ?? '-'}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text('Start: ${batch.startDate?.toString().split(' ')[0] ?? '-'} | End: ${batch.endDate?.toString().split(' ')[0] ?? '-'}', style: const TextStyle(color: Colors.white70)),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
