import 'package:flutter/material.dart';
import 'package:inshorts_movie_app_task/controllers/movies_controller.dart';
import 'package:inshorts_movie_app_task/controllers/movie_detail_controller.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/domain/repositories/locator.dart';

class BookMarkIconWidget extends StatelessWidget {
  final MovieDetailController? movieDetailControllder;
  final MovieModel movie;
  final bool isSmall;
  const BookMarkIconWidget({
    super.key,
    required this.movie,
    this.isSmall = false,
    this.movieDetailControllder,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      Icons.bookmark_rounded,
      color: movie.isBookmarked ? Colors.red : null,
    );
    return isSmall
        ? GestureDetector(onTap: onTap, child: icon)
        : IconButton(onPressed: onTap, icon: icon);
  }

  void onTap() async {
    await locator<MoviesController>().toggleBookmark(movie);
    if (movieDetailControllder != null) {
      movieDetailControllder!.movie.refresh();
    }
  }
}
