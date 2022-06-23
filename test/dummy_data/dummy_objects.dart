import 'package:tv_series_imdb/data/models/tv_table.dart';
import 'package:tv_series_imdb/domain/entities/genre.dart';
import 'package:tv_series_imdb/domain/entities/season.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';

final testTv = Tv(
    adult: false,
    backdropPath: "/56v2KjBlU4XaOv9rVYEQypROD7P.jpg",
    firstAirDate: "2016-07-15",
    genreIds: [10765, 18, 9648],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    lastAirDate: 'lastAirDate',
    name: 'Stranger Things',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: "en",
    originalName: "Stranger Things",
    overview:
        "When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.",
    popularity: 2956.23,
    posterPath: "/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 8.6,
    voteCount: 10891);

final testSeasons = Season(
    id: 1,
    name: 'name',
    air_date: 'air_date',
    poster_path: '/path.jpg',
    season_number: 1,
    episode_count: 1,
    overview: 'overview');
final testTvDetail = TvDetail(
    adult: false,
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    seasons: [
      Season(
          id: 1,
          name: 'name',
          air_date: 'air_date',
          poster_path: '/path.jpg',
          season_number: 1,
          episode_count: 1,
          overview: 'overview')
    ],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: '/path.jpg',
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1);
final testTvList = [testTv];
final testSeasonsList = [testSeasons];
final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testTvTable = TvTable(
    id: 1, name: 'name', posterPath: 'posterPath', overview: 'overview');

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
