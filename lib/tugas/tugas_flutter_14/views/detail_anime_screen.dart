import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/anime_models.dart' as model;
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/bookmark_manager.dart';

class DetailAnimeScreen extends StatelessWidget {
  final model.Datum anime;

  const DetailAnimeScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final imageUrl = anime.images['jpg']?.largeImageUrl ?? anime.images['jpg']?.imageUrl ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          ValueListenableBuilder<List<model.Datum>>(
            valueListenable: BookmarkManager.bookmarksNotifier,
            builder: (context, bookmarks, child) {
              final isBookmarked = bookmarks.any((element) => element.malId == anime.malId);
              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  BookmarkManager.toggleBookmark(anime);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isBookmarked ? 'Dihapus dari Bookmark' : 'Ditambahkan ke Bookmark'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 300,
                  child: Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              )
            else
              const SizedBox(
                height: 300,
                child: Center(child: Icon(Icons.image_not_supported, size: 50)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  if (anime.titleJapanese.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      anime.titleJapanese,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn(Icons.star, 'Score', anime.score.toString()),
                      _buildInfoColumn(Icons.tv, 'Episodes', anime.episodes?.toString() ?? '-'),
                      _buildInfoColumn(Icons.info_outline, 'Status', _formatStatus(anime.status)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Synopsis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime.synopsis.isNotEmpty ? anime.synopsis : 'No synopsis available.',
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  String _formatStatus(model.Status status) {
    switch (status) {
      case model.Status.CURRENTLY_AIRING:
        return 'Airing';
      case model.Status.FINISHED_AIRING:
        return 'Finished';
      default:
        return 'Unknown';
    }
  }
}
