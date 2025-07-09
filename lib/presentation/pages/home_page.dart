import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inshorts_movie_app_task/controllers/movies_controller.dart';
import 'package:inshorts_movie_app_task/domain/repositories/locator.dart';
import 'package:inshorts_movie_app_task/presentation/pages/saved_movies/saved_movies_page.dart';
import 'package:inshorts_movie_app_task/presentation/pages/search_movies/search_movies_page.dart';
import 'package:inshorts_movie_app_task/presentation/widgets/movie_poster_ui_widget.dart';
import 'package:inshorts_movie_app_task/shared/extension.dart';
import 'package:inshorts_movie_app_task/shared/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/models/movie_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String tag = "HomePage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          actions: [
            IconButton(
              tooltip: 'Saved/Bookmarked Movies',
              onPressed: () {
                Get.to(SavedMoviesPage());
              },
              icon: Icon(Icons.bookmark_rounded),
            ),
            IconButton(
              tooltip: 'Search Movies',
              onPressed: () {
                Get.to(SearchMoviesPage());
              },
              icon: Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              movieSection(
                title: 'Trending Movies',
                controllerValue: locator<MoviesController>().trendingMovies,
              ),
              movieSection(
                title: 'Now Playing',
                controllerValue: locator<MoviesController>().nowPlayingMovies,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox movieSection({
    required String title,
    required Rx<List<MovieModel>?> controllerValue,
  }) {
    return SizedBox(
      height: 250.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: h2eadingTextStyle(),
          ).withAllPaddingEight().withLeftPaddingEight(),
          Expanded(
            child: Obx(() {
              final List<MovieModel>? movies = controllerValue.value;
              if (movies?.isEmpty ?? false) {
                return Text('Failed to Load TMDB Data/API Error!', style: errorTextStyle(),).withAllPaddingSixteen();
               }
              if (movies != null) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final MovieModel movie = movies[index];
                    return MoviePosterWidget(movie: movie);
                  },
                );
              }
              return shimmerEffect();
            }),
          ),
        ],
      ),
    );
  }

  ListView shimmerEffect() {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Card(
              child: SizedBox(height: 170.h, width: 120.h),
            ),
          ),
        );
      },
    );
  }
}
