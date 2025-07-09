import 'package:flutter/widgets.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/presentation/widgets/movie_poster_ui_widget.dart';
import 'package:inshorts_movie_app_task/shared/extension.dart';

class MoviesGridWidget extends StatelessWidget {
  final List<MovieModel> movies;
  const MoviesGridWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 2,
      ),
      itemBuilder: (context, index) {
        final MovieModel movieModel = movies[index];
        return MoviePosterWidget(movie: movieModel);
      },
    ).withAllPaddingFour();
  }
}
