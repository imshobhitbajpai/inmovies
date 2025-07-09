import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inshorts_movie_app_task/core/network/tmdb_helper.dart';
import 'package:inshorts_movie_app_task/data/models/movie_model.dart';
import 'package:inshorts_movie_app_task/presentation/pages/movie_detail_page.dart';
import 'package:inshorts_movie_app_task/presentation/widgets/bookmark_icon_widget.dart';

class MoviePosterWidget extends StatelessWidget {
  const MoviePosterWidget({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(MovieDetailPage(movieId: movie.id));
          },
          child: Card(
            child: SizedBox(
              height: 190.h,
              width: 120.w,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      child: ExtendedImage.network(
                        TMDBHelper.getPosterUrl(
                          movie.posterPath ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BookMarkIconWidget(
                            movie: movie,
                            isSmall: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
