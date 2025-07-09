import 'package:hive/hive.dart';
import 'package:inshorts_movie_app_task/core/db/boxes.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';

class MovieLocalDataSource {
  late final Box<MovieModel> box;

  MovieLocalDataSource() {
    box = Boxes.moviesBox();
  }

  Future<void> cacheMovies(List<MovieModel> movies, String category) async {
    final alreadyBookMarked = box.values
        .where((m) => m.isBookmarked)
        .map((e) => e.id);
    final categorisedList = box.values
        .where((c) => c.category == category)
        .toList();
    for (var e in categorisedList) {
      await e.delete();
    }
    for (var m in movies) {
      m.category = category;
      if (alreadyBookMarked.contains(m.id)) {
        m.isBookmarked = true;
      }
    }
    await box.addAll(movies);
  }

  Future<List<MovieModel>> getCachedMovies(String category) async {
    return box.values.where((v) => v.category == category).toList();
  }

  List<MovieModel> getBookmarkedMovies() {
    final bookMarked = box.values.where((m) => m.isBookmarked).toList();
    final seenIds = <int>{};
    final uniques = bookMarked.where((v) => seenIds.add(v.id)).toList();
    return uniques;
  }

  List<MovieModel> getUniqueCachedMovies() {
    final seenIds = <int>{};
    final uniques = box.values.where((v) => seenIds.add(v.id)).toList();
    return uniques;
  }

  Future<void> toggleBookmark(MovieModel movie) async {
    if(box.values.where((m) => m.id == movie.id).isEmpty) {
    await box.add(movie);
    }
    final matchingIdsList = box.values.where((m) => m.id == movie.id).toList();
    for (var m in matchingIdsList) {
      m.isBookmarked = !m.isBookmarked;
      await m.save();
    }
  }
}
