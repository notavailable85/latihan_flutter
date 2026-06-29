import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/anime_models.dart' hide Image;
import 'package:latihan_flutter/tugas/tugas_flutter_14/services/api_services.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/services/dio_client.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/views/detail_anime_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/bookmark_manager.dart';

class GetAnimeScreen extends StatefulWidget {
  const GetAnimeScreen({super.key});

  @override
  State<GetAnimeScreen> createState() => _GetAnimeScreenState();
}

class _GetAnimeScreenState extends State<GetAnimeScreen> {
  late final ApiService _apiService;
  late Future<AnimeModels> _animeFuture;
  String _searchQuery = '';
  
  // Filter states
  List<DatumType> _selectedTypes = [];
  List<Rating> _selectedRatings = [];
  List<Source> _selectedSources = [];
  String? _selectedGenre;
  bool _sortByPopularity = false;

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
          
          final uniqueGenres = <String>{};
          for (var anime in animes) {
            for (var genre in anime.genres) {
              uniqueGenres.add(genre.name);
            }
          }
          final genreList = uniqueGenres.toList()..sort();

          var filteredAnimes = animes.where((anime) {
            final matchSearch = anime.title.toLowerCase().contains(_searchQuery.toLowerCase());
            final matchType = _selectedTypes.isEmpty || _selectedTypes.contains(anime.type);
            final matchRating = _selectedRatings.isEmpty || _selectedRatings.contains(anime.rating);
            final matchSource = _selectedSources.isEmpty || _selectedSources.contains(anime.source);
            final matchGenre = _selectedGenre == null || anime.genres.any((g) => g.name == _selectedGenre);

            return matchSearch && matchType && matchRating && matchSource && matchGenre;
          }).toList();

          if (_sortByPopularity) {
            filteredAnimes.sort((a, b) => a.popularity.compareTo(b.popularity));
          }

          return RefreshIndicator(
            onRefresh: () async => _refreshAnime(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
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
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.filter_list, color: Colors.white),
                          onPressed: () => _showFilterModal(context, genreList),
                        ),
                      ),
                    ],
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
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
                              ValueListenableBuilder<List<Datum>>(
                                valueListenable: BookmarkManager.bookmarksNotifier,
                                builder: (context, bookmarks, child) {
                                  final isBookmarked = BookmarkManager.isBookmarked(anime);
                                  return IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: Icon(
                                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                      color: isBookmarked ? Colors.blueAccent : Colors.grey,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      BookmarkManager.toggleBookmark(anime);
                                    },
                                  );
                                },
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

  void _showFilterModal(BuildContext context, List<String> availableGenres) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Filter Anime', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    
                    // Type Filter
                    const Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: DatumType.values.map((type) {
                        return FilterChip(
                          label: Text(type.name),
                          selected: _selectedTypes.contains(type),
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                _selectedTypes.add(type);
                              } else {
                                _selectedTypes.remove(type);
                              }
                            });
                            setState(() {}); // Update main UI
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // Rating Filter
                    const Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: Rating.values.map((rating) {
                        return FilterChip(
                          label: Text(rating.name),
                          selected: _selectedRatings.contains(rating),
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                _selectedRatings.add(rating);
                              } else {
                                _selectedRatings.remove(rating);
                              }
                            });
                            setState(() {}); // Update main UI
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // Source Filter
                    const Text('Source', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: Source.values.map((source) {
                        return FilterChip(
                          label: Text(source.name),
                          selected: _selectedSources.contains(source),
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                _selectedSources.add(source);
                              } else {
                                _selectedSources.remove(source);
                              }
                            });
                            setState(() {}); // Update main UI
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // Genres Filter
                    const Text('Genre', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Pilih Genre'),
                      value: _selectedGenre,
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Semua Genre'),
                        ),
                        ...availableGenres.map((genre) {
                          return DropdownMenuItem<String>(
                            value: genre,
                            child: Text(genre),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setModalState(() {
                          _selectedGenre = value;
                        });
                        setState(() {}); // Update main UI
                      },
                    ),
                    const SizedBox(height: 12),

                    // Popularity Sort
                    SwitchListTile(
                      title: const Text('Urutkan Berdasarkan Popularitas'),
                      contentPadding: EdgeInsets.zero,
                      value: _sortByPopularity,
                      onChanged: (value) {
                        setModalState(() {
                          _sortByPopularity = value;
                        });
                        setState(() {}); // Update main UI
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setModalState(() {
                            _selectedTypes.clear();
                            _selectedRatings.clear();
                            _selectedSources.clear();
                            _selectedGenre = null;
                            _sortByPopularity = false;
                          });
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Reset Filter'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
