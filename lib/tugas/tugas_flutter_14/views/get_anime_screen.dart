import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/anime_models.dart' hide Image;
import 'package:latihan_flutter/tugas/tugas_flutter_14/services/api_services.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/services/dio_client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/views/detail_anime_screen.dart';

class GetAnimeScreen extends StatefulWidget {
  const GetAnimeScreen({super.key});

  @override
  State<GetAnimeScreen> createState() => _GetAnimeScreenState();
}

class _GetAnimeScreenState extends State<GetAnimeScreen> {
  late final ApiService _apiService;
  late Future<AnimeModels> _animeFuture;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _apiService = ApiService(dio);
    _animeFuture = _apiService.getAllPosts();
  }

  void _refreshAnime() {
    setState(() {
      _animeFuture = _apiService.getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<AnimeModels>(
        future: _animeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Gagal memuat data:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshAnime,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text('Tidak ada data anime.'));
          }

          final animes = snapshot.data!.data;
          final filteredAnimes = animes.where((anime) {
            return anime.title.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();

          return RefreshIndicator(
            onRefresh: () async => _refreshAnime(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari anime...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: filteredAnimes.isEmpty
                      ? const Center(child: Text('Anime tidak ditemukan.'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: filteredAnimes.length,
                          itemBuilder: (context, index) {
                            final anime = filteredAnimes[index];
                final imageUrl = anime.images['jpg']?.imageUrl ?? '';

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailAnimeScreen(anime: anime),
                      ),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 50),
                                )
                              : const Icon(Icons.image_not_supported, size: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                anime.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    anime.score.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  },
      ),
    );
  }
}
