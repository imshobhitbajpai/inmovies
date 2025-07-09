import 'package:get_it/get_it.dart';
import 'package:inshorts_movie_app_task/controllers/dio_controller.dart';
import 'package:inshorts_movie_app_task/controllers/internet_connectivity_checker.dart';
import 'package:inshorts_movie_app_task/controllers/movies_controller.dart';

final GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(() => MoviesController());
  locator.registerLazySingleton(() => DioController());
  //
  locator.registerSingleton<InternetConnectivity>(InternetConnectivity());
}
