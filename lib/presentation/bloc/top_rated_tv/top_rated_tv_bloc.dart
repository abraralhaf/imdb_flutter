import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  GetTopRatedTv _getTopRatedTv;
  TopRatedTvBloc(this._getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<TopRatedTvFetch>(_onTopRatedTvFetch);
  }

  FutureOr<void> _onTopRatedTvFetch(
      TopRatedTvFetch event, Emitter<TopRatedTvState> emit) async {
    emit(TopRatedTvLoading());
    final result = await _getTopRatedTv.execute();

    result.fold((failure) => emit(TopRatedTvError(failure.message)), (data) {
      data.isEmpty ? emit(TopRatedTvEmpty()) : emit(TopRatedTvHasData(data));
    });
  }
}
