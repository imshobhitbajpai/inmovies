import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:inshorts_movie_app_task/controllers/movie_detail_controller.dart';
import 'package:inshorts_movie_app_task/core/network/tmdb_helper.dart';
import 'package:inshorts_movie_app_task/presentation/widgets/bookmark_icon_widget.dart';
import 'package:inshorts_movie_app_task/shared/extension.dart';
import 'package:inshorts_movie_app_task/shared/text_styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;
  const MovieDetailPage({super.key, required this.movieId});
  static const String tag = "MovieDetailPage";

  @override
  Widget build(BuildContext context) {
    final movieDetailsController = MovieDetailController(movieId);
    return Obx(() {
      final MovieModel? movie = movieDetailsController.movie.value;
      if (movie == null) {
        return Scaffold(
          appBar: AppBar(),
          body: movieDetailsController.isExceptionThrowed.value
              ? Expanded(
                  child: Center(child: Text('Oops! Movie Details Not Found.')),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade800,
                  highlightColor: Colors.grey.shade700,
                  child: Container(
                    height: context.height,
                    width: context.width,
                    color: Colors.black,
                  ),
                ),
        );
      }
      return Stack(
        children: [
          SizedBox.expand(
            child: ExtendedImage.network(
              TMDBHelper.getPosterUrl(movie.posterPath ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  BookMarkIconWidget(
                    movie: movie,
                    movieDetailControllder: movieDetailsController,
                  ),
                  IconButton(
                    onPressed: () {
                      final link = "movieapp://movie/${movie.id}";
                      final message =
                          "Check out this movie: ${movie.title}\n$link";
                      SharePlus.instance.share(ShareParams(text: message));
                    },
                    icon: Icon(Icons.share_rounded),
                  ),
                ],
              ),
              body: Column(
                children: [
                  const Spacer(),
                  GlassContainer.clearGlass(
                    height: 300.h,
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.40),
                        Colors.black.withOpacity(0.10),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.60),
                        Colors.white.withOpacity(0.10),
                        Colors.lightBlueAccent.withOpacity(0.05),
                        Colors.lightBlueAccent.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.39, 0.40, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    blur: 25.0,
                    borderWidth: 1.5,
                    elevation: 3.0,
                    shadowColor: Colors.black.withOpacity(0.20),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: h1eadingTextStyle(),
                          ).withBottomPaddingSixteen(),
                          Text(
                            'Drama, Comedy (Fake)',
                            style: h4TextStyle(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ).withRightPaddingFour(),
                              Text('8.0').withRightPaddingEight(),
                              Icon(
                                Icons.circle_rounded,
                                size: 12,
                              ).withOpacity().withRightPaddingFour(),
                              Text('2019').withRightPaddingEight(),
                              Icon(
                                Icons.circle_rounded,
                                size: 12,
                              ).withOpacity().withRightPaddingFour(),
                              Text(
                                '120 Minutes (Fake)',
                              ).withRightPaddingEight(),
                            ],
                          ).withBottomPaddingSixteen(),
                          if (movie.overview != null)
                            Text(
                              movie.overview!,
                              maxLines: 5,
                            ).withBottomPaddingSixteen(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.play_arrow_rounded),
                                onPressed: () {},
                                label: Text('Watch Movie'),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                child: Text('Trailer'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).withAllPaddingEight(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
