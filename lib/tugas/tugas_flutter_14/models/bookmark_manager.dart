import 'package:flutter/foundation.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/anime_models.dart';

class BookmarkManager {
  static final ValueNotifier<List<Datum>> bookmarksNotifier = ValueNotifier([]);

  static void toggleBookmark(Datum anime) {
    final list = List<Datum>.from(bookmarksNotifier.value);
    final index = list.indexWhere((element) => element.malId == anime.malId);
    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.add(anime);
    }
    bookmarksNotifier.value = list;
  }

  static bool isBookmarked(Datum anime) {
    return bookmarksNotifier.value.any((element) => element.malId == anime.malId);
  }
}
