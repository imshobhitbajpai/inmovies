import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class MovieModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @HiveField(3)
  final String? overview;

  @HiveField(4)
  bool isBookmarked;

  @HiveField(5)
  String? category;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    this.isBookmarked = false,
    this.category,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
