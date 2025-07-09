class TMDBHelper {
  static String getPosterUrl(String path) {
    String size = 'w500';
    return 'https://image.tmdb.org/t/p/$size$path';
  }
}