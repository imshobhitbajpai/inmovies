import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:get/get.dart';
import 'package:inshorts_movie_app_task/data/datasources/movie_local_data_source.dart';
import 'package:inshorts_movie_app_task/data/datasources/movie_remote_data_source.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/data/repositories/movie_repository_impl.dart';

class MoviesController extends GetxController {
  Rx<List<MovieModel>?> trendingMovies = (null as List<MovieModel>?).obs;
  Rx<List<MovieModel>?> nowPlayingMovies = (null as List<MovieModel>?).obs;
  Rx<List<MovieModel>?> searchedMovies = (null as List<MovieModel>?).obs;
  RxList<MovieModel> savedMovies = <MovieModel>[].obs;

  final Debouncer debouncer = Debouncer();
  RxBool isSearching = false.obs;

  MoviesController() {
    loadTrendingMovies();
    loadNowPlayingMovies();
    loadBookmarkedMovies();
  }

  Future<void> loadTrendingMovies() async {
    final repository = MovieRepositoryImpl(
      MovieRemoteDataSource(),
      MovieLocalDataSource(),
    );

    final trending = await repository.getTrendingMovies();
    trendingMovies.value = trending;
  }

  Future<void> loadNowPlayingMovies() async {
    final repository = MovieRepositoryImpl(
      MovieRemoteDataSource(),
      MovieLocalDataSource(),
    );

    final trending = await repository.getNowPlayingMovies();
    nowPlayingMovies.value = trending;
  }

  void loadBookmarkedMovies() {
    savedMovies.value = getBookmarkedMovies();
  }

  Future<void> toggleBookmark(MovieModel movie) async {
    await MovieLocalDataSource().toggleBookmark(movie);
    trendingMovies.refresh();
    nowPlayingMovies.refresh();
    searchedMovies.refresh();
    savedMovies.value = getBookmarkedMovies();
  }

  List<MovieModel> getBookmarkedMovies() {
    return MovieLocalDataSource().getBookmarkedMovies();
  }

  void searchQuery(String query) {
    isSearching.value = true;
    const duration = Duration(milliseconds: 1500);
    debouncer.debounce(
      duration: duration,
      onDebounce: () async {
        if (query.isEmpty) {
          searchedMovies.value = null;
          isSearching.value = false;
          return;
        }
        searchedMovies.value = await MovieRepositoryImpl(
          MovieRemoteDataSource(),
          MovieLocalDataSource(),
        ).searchMovies(query);
        isSearching.value = false;
      },
    );
  }
}
