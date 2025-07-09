import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:inshorts_movie_app_task/data/datasources/movie_local_data_source.dart';
import 'package:inshorts_movie_app_task/data/datasources/movie_remote_data_source.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/data/repositories/movie_repository_impl.dart';

class MovieDetailController extends GetxController {
  Rx<MovieModel?> movie = (null as MovieModel?).obs;
  RxBool isExceptionThrowed = false.obs;
  MovieDetailController(int movieId) {
    loadMovieInfo(movieId);
  }

  void loadMovieInfo(int movieId) async {
    try {
      movie.value = await MovieRepositoryImpl(
        MovieRemoteDataSource(),
        MovieLocalDataSource(),
      ).getMovieDetail(movieId);
    } catch (e) {
      debugPrint("### loadMovieInfo Exception: ${e.toString()} ###");
      isExceptionThrowed.value = true;
    }
  }
}
