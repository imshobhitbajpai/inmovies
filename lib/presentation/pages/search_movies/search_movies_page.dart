import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inshorts_movie_app_task/controllers/movies_controller.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/domain/repositories/locator.dart';
import 'package:inshorts_movie_app_task/presentation/widgets/movie_grid_widget.dart';
import 'package:inshorts_movie_app_task/shared/extension.dart';

class SearchMoviesPage extends StatelessWidget {
  const SearchMoviesPage({super.key});
  static const String tag = "SearchMoviesPage";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if(didPop) {
          locator<MoviesController>().searchedMovies.value = null;
          locator<MoviesController>().isSearching.value = false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              SearchBar(
                hintText: 'Avengers',
                onChanged: (query) {
                  locator<MoviesController>().searchQuery(query);
                },
                autoFocus: true,
                leading: Icon(Icons.search_rounded),
              ).withAllPaddingEight(),
              Expanded(
                child: Obx(() {
                  final List<MovieModel>? movies =
                      locator<MoviesController>().searchedMovies.value;
                      final bool isSearching = locator<MoviesController>().isSearching.value;
                  if (isSearching) {
                    return Center(child: SizedBox(height: 24.w,width: 24.w, child: CircularProgressIndicator(),));
                  }
                  if (movies == null) {
                    return Center(child: Text('Search Movies by Title'));
                  }
                  if (movies.isEmpty) {
                    return Center(child: Text('No Movies Found'));
                  }
                  return MoviesGridWidget(movies: movies);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
