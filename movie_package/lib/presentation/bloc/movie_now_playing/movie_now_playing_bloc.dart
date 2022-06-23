import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  MovieNowPlayingBloc(this._getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<FetchMovieNowPlaying>(_fetchNowPlaingMovie);
  }

  FutureOr<void> _fetchNowPlaingMovie(
      FetchMovieNowPlaying event, Emitter<MovieNowPlayingState> emit) async {
    emit(MovieNowPlayingLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) {
      emit(MovieNowPlayingError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(MovieNowPlayingEmpty())
          : emit(MovieNowPlayingHasData(data));
    });
  }
}
