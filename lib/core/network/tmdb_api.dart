import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../data/models/movie_response.dart';

part 'tmdb_api.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class TMDBApi {
  static const String apiKey = 'a46a6e6097b8cff18aeef9182d23765d';
  factory TMDBApi(Dio dio, {String baseUrl}) = _TMDBApi;

  @GET("trending/movie/week")
  Future<MovieResponse> getTrending();

  @GET("movie/now_playing")
  Future<MovieResponse> getNowPlaying();

  @GET("search/movie")
  Future<MovieResponse> searchMovies(@Query("query") String title);

  @GET("movie/{movie_id}")
  Future<MovieModel> getMovieDetail(@Path("movie_id") int id);
}
