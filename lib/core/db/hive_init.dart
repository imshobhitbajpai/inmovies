import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/movie_model.dart';

Future<void> initHive() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>('moviesBox');
}
