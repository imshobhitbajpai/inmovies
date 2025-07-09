import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:inshorts_movie_app_task/core/network/tmdb_api.dart';

class DioController {
  late final Dio dio;

  DioController() {
    dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({'api_key': TMDBApi.apiKey});
          debugPrint("### RequestURL: ${options.uri.toString()} ###");
          return handler.next(options);
        },
      ),
    );
  }
}
