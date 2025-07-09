import 'package:hive/hive.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';

class Boxes {  
static Box<MovieModel> moviesBox() {
  return Hive.box('moviesBox');
}
}