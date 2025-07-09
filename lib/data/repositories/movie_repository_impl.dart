import 'package:flutter/foundation.dart';
import 'package:get/utils.dart';

import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';
import '../datasources/movie_local_data_source.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final MovieLocalDataSource local;

  MovieRepositoryImpl(this.remote, this.local);

  List<MovieModel> localQuery(String query) {
    final filtered = local
        .getUniqueCachedMovies()
        .where(
          (model) => model.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    final sortedList = sortQueryInDictionaryOrder(filtered, query).toList();
    return sortedList;
  }

  List<MovieModel> sortQueryInDictionaryOrder(
    List<MovieModel> filtered,
    query,
  ) {
    filtered.sort((a, b) {
      String aLower = a.title.toLowerCase();
      String bLower = b.title.toLowerCase();

      int relevance(String s) {
        if (s.startsWith(query)) return 0;
        if (s.contains(query)) return 1;
        return 2;
      }

      int aScore = relevance(aLower);
      int bScore = relevance(bLower);
      if (aScore != bScore) return aScore.compareTo(bScore);

      return aLower.compareTo(bLower);
    });

    return filtered;
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final String category = 'trending';
    try {
      final remoteMovies = await remote.getTrending();
      await local.cacheMovies(remoteMovies, category);
      return remoteMovies;
    } catch (e) {
      debugPrint("### getTrendingMovies Exception: ${e.toString()} ###");
      return await local.getCachedMovies(category);
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final String category = 'now_playing';
    try {
      final remoteMovies = await remote.getNowPlaying();
      await local.cacheMovies(remoteMovies, category);
      return remoteMovies;
    } catch (e) {
      debugPrint("### getNowPlayingMovies Exception: ${e.toString()} ###");
      return await local.getCachedMovies(category);
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final searched = await remote.searchMovies(query);
      return searched;
    } catch (e) {
      debugPrint("### searchMovies Exception: ${e.toString()} ###");
      final searched = localQuery(query);
      return searched;
    }
  }

  @override
  Future<MovieModel> getMovieDetail(int id) async {
    try {
      final localMovie = local.getUniqueCachedMovies().firstWhereOrNull(
        (m) => m.id == id,
      );
      if (localMovie != null) {
        return localMovie;
      } else {
        final movie = await remote.getMovieDetail(id);
        return movie;
      }
    } catch (e) {
      debugPrint("### getMovieDetail Exception: ${e.toString()} ###");
      throw 'No Movie Details Available';
    }
  }
}
