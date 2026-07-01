import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/dio.client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/services/training_service.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/training_detail_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/widgets/glassmorphism_widgets.dart';

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({super.key});

  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  final trainingService = TrainingService(createDioClient());
  List<Training> _trainings = [];
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _fetchTrainings();
  }

  Future<void> _fetchTrainings() async {
    try {
      final response = await trainingService.getTrainings();
      if (mounted) {
        setState(() {
          _trainings = response.data ?? [];
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
        title: const Text('Daftar Pelatihan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                    itemCount: _trainings.length,
                    itemBuilder: (context, index) {
                      final training = _trainings[index];
                      return GlassContainer(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(training.title ?? '-', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainingDetailScreen(id: training.id!),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
