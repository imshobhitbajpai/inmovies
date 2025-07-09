import 'package:inshorts_movie_app_task/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> searchMovies(String query);
  Future<MovieModel> getMovieDetail(int id);
}
