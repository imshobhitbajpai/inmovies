// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inshorts_movie_app_task/controllers/movies_controller.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/domain/repositories/locator.dart';
import 'package:inshorts_movie_app_task/presentation/widgets/movie_grid_widget.dart';

class SavedMoviesPage extends StatelessWidget {
  const SavedMoviesPage({super.key});
  static const String tag = "=====SavedMoviesPage=====";

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<MovieModel> savedMovies =
          locator<MoviesController>().savedMovies.value;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Saved Movies')),
          body: savedMovies.isEmpty ? Center(child: Text('No Saved/Bookmarked Movies Found.')) : MoviesGridWidget(movies: savedMovies),
        ),
      );
    });
  }
}
