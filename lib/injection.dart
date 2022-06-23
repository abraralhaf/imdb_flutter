import 'package:get_it/get_it.dart';
import 'package:movie_package/data/datasources/movie_local_data_source.dart';
import 'package:movie_package/data/datasources/movie_remote_data_source.dart';
import 'package:movie_package/data/repositories/movie_repository_impl.dart';
import 'package:movie_package/domain/repositories/movie_repository.dart';
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:tv_series_imdb/common/http_ssl_pinning.dart';
import 'package:tv_series_imdb/data/datasources/db/db_helper.dart';
import 'package:tv_series_imdb/data/datasources/local/tv_local_data_source.dart';
import 'package:tv_series_imdb/data/datasources/remote/tv_remote_data_source.dart';
import 'package:tv_series_imdb/data/repositories/tv_repository_impl.dart';
import 'package:tv_series_imdb/domain/repositories/tv_repository.dart';
import 'package:tv_series_imdb/domain/usecases/get_detail_tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_now_playing_tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_popular_tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series_imdb/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series_imdb/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series_imdb/domain/usecases/remove_watchlist.dart';
import 'package:tv_series_imdb/domain/usecases/save_watchlist.dart';
import 'package:tv_series_imdb/domain/usecases/search_tv.dart';

import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/recommendation_tv/bloc/recommendation_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

import 'package:http/http.dart' as http;


import 'package:movie_package/domain/usecases/get_movie_detail.dart';
import 'package:movie_package/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_package/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_package/domain/usecases/get_popular_movies.dart';
import 'package:movie_package/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_package/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_package/domain/usecases/get_watchlist_status.dart'
    as getWatchlistStatusMovie;
import 'package:movie_package/domain/usecases/remove_watchlist.dart'
    as removeWatchlistMovie;
import 'package:movie_package/domain/usecases/save_watchlist.dart'
    as saveWatchlistMovie;
import 'package:movie_package/domain/usecases/search_movies.dart';

import 'package:movie_package/data/datasources/db/database_helper.dart'
    as dbMovie;

final locator = GetIt.instance;

void init() {
  //bloc tv
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => DetailTvBloc(locator()));
  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(
      () => WatchlistTvBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => RecommendationTvBloc(locator()));
  //bloc movie
  locator.registerFactory(
      () => MovieWatchlistBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieNowPlayingBloc(locator()));
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator())); 
  locator.registerFactory(() => MovieTopRatedBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  //provider movie
 // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetDetailTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchList(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(
      () => getWatchlistStatusMovie.GetWatchListStatus(locator()));
  locator
      .registerLazySingleton(() => saveWatchlistMovie.SaveWatchlist(locator()));
  locator.registerLazySingleton(
      () => removeWatchlistMovie.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //repository
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));
  //repo movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // ds movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  //helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //helper movie
  locator.registerLazySingleton<dbMovie.DatabaseHelper>(
      () => dbMovie.DatabaseHelper());

  //external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
