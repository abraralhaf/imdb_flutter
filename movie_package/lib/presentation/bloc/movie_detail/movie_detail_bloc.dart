import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_package/domain/entities/movie_detail.dart';
import 'package:movie_package/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(_fetchMovieDetail);
  }

  FutureOr<void> _fetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    final id = event.id;
    emit(MovieDetailLoading());
    final result = await _getMovieDetail.execute(id);

    result.fold((failure) {
      emit(MovieDetailError(failure.message));
    }, (data) {
      emit(MovieDetailHasData(data));
    });
  }
}
