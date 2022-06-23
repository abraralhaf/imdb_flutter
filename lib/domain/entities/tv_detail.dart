import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/data/models/genre_model.dart';
import 'package:tv_series_imdb/domain/entities/genre.dart';
import 'package:tv_series_imdb/domain/entities/season.dart';

class TvDetail {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.seasons,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });
  bool? adult;
  String? backdropPath;
  String? firstAirDate;
  List<Genre> genres;
  List<Season> seasons;
  String? homepage;
  int id;
  bool? inProduction;
  String? lastAirDate;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String? originalLanguage;
  String? originalName;
  String? overview;
  num? popularity;
  String? posterPath;
  String? status;
  String? tagline;
  String? type;
  double voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        firstAirDate,
        genres,
        homepage,
        id,
        seasons,
        inProduction,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
