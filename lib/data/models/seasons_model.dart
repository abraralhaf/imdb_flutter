import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/genre.dart';
import 'package:tv_series_imdb/domain/entities/season.dart';

class SeasonModel extends Equatable {
  SeasonModel(
      {required this.id,
      required this.name,
      required this.air_date,
      required this.poster_path,
      required this.season_number,
      required this.episode_count,
      required this.overview});

  final int id;
  final String air_date;
  final String overview;
  final String poster_path;
  final int episode_count;
  final int season_number;
  final String name;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        air_date: json["air_date"] ?? "",
        poster_path: json["poster_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        episode_count: json["episode_count"],
        season_number: json["season_number"],
        overview: json["overview"] ?? "Empty filled",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": air_date,
        "poster_path": poster_path,
        "episode_count": episode_count,
        "season_number": season_number
      };

  Season toEntity() {
    return Season(
      id: this.id,
      name: this.name,
      overview: this.overview,
      episode_count: this.episode_count,
      poster_path: this.poster_path,
      season_number: this.season_number,
      air_date: this.air_date,
    );
  }

  @override
  List<Object> get props =>
      [id, name, air_date, overview, episode_count, poster_path, season_number];
}
