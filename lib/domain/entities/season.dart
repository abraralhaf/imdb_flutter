import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season(
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
  final int season_number;
  final int episode_count;
  final String name;

  @override
  List<Object> get props =>
      [id, name, episode_count,air_date, overview, poster_path, season_number];
}
