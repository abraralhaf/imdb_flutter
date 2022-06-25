import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/domain/entities/movie_detail.dart';
import 'package:movie_package/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_package/domain/usecases/get_watchlist_status.dart';
import 'package:movie_package/domain/usecases/remove_watchlist.dart';
import 'package:movie_package/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  MovieWatchlistBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._removeWatchlist, this._saveWatchlist)
      : super(MovieWatchlistInitial()) {
    on<FetchMovieWatchList>(_FetchMovieWatchList);
    on<MovieWatchListStatus>(_onMovieWatchListStatus);
    on<MovieWatchListAdd>(_onMovieWatchListAdd);
    on<MovieWatchListRemove>(_onMovieWatchListRemove);
  }

  FutureOr<void> _FetchMovieWatchList(
      FetchMovieWatchList event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchListLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(MovieWatchListError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(MovieWatchListEmpty())
          : emit(MovieWatchListHasData(data));
    });
  }

  FutureOr<void> _onMovieWatchListStatus(
      MovieWatchListStatus event, Emitter<MovieWatchlistState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatus.execute(id);

    emit(MovieWatchListIsAdded(result));
  }

  FutureOr<void> _onMovieWatchListAdd(
      MovieWatchListAdd event, Emitter<MovieWatchlistState> emit) async {
    final movie = event.movieDetail;

    final result = await _saveWatchlist.execute(movie);
    result.fold((failure) {
      emit(MovieWatchListError(failure.message));
    }, (data) {
      emit(MovieWatchListMessage(data));
    });
  }

  FutureOr<void> _onMovieWatchListRemove(
      MovieWatchListRemove event, Emitter<MovieWatchlistState> emit) async {
    final movie = event.movieDetail;
    final result = await _removeWatchlist.execute(movie);
    result.fold((failure) {
      emit(MovieWatchListError(failure.message));
    }, (data) {
      emit(MovieWatchListMessage(data));
    });
  }
}
