import 'package:inshorts_movie_app_task/controllers/dio_controller.dart';
import 'package:inshorts_movie_app_task/core/network/tmdb_api.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/domain/repositories/locator.dart';

class MovieRemoteDataSource {
  late final TMDBApi api;

  MovieRemoteDataSource() {
    api = TMDBApi(locator<DioController>().dio);
  }

  Future<List<MovieModel>> getTrending() async {
    final res = await api.getTrending();
    return res.results;
  }

  Future<List<MovieModel>> getNowPlaying() async {
    final res = await api.getNowPlaying();
    return res.results;
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    final res = await api.searchMovies(query);
    return res.results;
  }

  Future<MovieModel> getMovieDetail(int id) async {
    final res = await api.getMovieDetail(id);
    return res;
  }
}
