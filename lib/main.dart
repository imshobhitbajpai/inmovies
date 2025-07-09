import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inshorts_movie_app_task/domain/repositories/locator.dart';
import 'package:inshorts_movie_app_task/presentation/pages/movie_detail_page.dart';
import 'core/db/hive_init.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appLinks = AppLinks();
  await initHive();
  initLocator();
  runApp(MovieApp());
  handleDeepLink(appLinks);
}

void handleDeepLink(AppLinks appLinks) {
  appLinks.uriLinkStream.listen((uri) {
    debugPrint("### URI: ${uri.toString()} ###");
    if (uri.authority == 'movie') {
    try {
      final int movieId = int.parse(uri.pathSegments.last);
      Future.delayed(Duration.zero, () {
        Get.to(MovieDetailPage(movieId: movieId));
      });
    } catch (e) {
      debugPrint("### Exception: ${e.toString()} ###");
    }
    }
  });
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inshorts Task',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
