import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/anime_models.dart' hide Image;
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/bookmark_manager.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/views/detail_anime_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Anime', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder<List<Datum>>(
        valueListenable: BookmarkManager.bookmarksNotifier,
        builder: (context, bookmarkedAnimes, child) {
          if (bookmarkedAnimes.isEmpty) {
            return const Center(child: Text('Belum ada anime yang ditandai.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: bookmarkedAnimes.length,
            itemBuilder: (context, index) {
              final anime = bookmarkedAnimes[index];
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
          );
        },
      ),
    );
  }
}
