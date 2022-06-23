import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  GetPopularTv _getPopularTv;
  
  PopularTvBloc(this._getPopularTv) : super(PopularTvEmpty()) {
    on<PopularTvFetch>(_onPopularTvFetch);
  }

  FutureOr<void> _onPopularTvFetch(
      PopularTvFetch event, Emitter<PopularTvState> emit) async {
    emit(PopularTvLoading());
    final result = await _getPopularTv.execute();

    result.fold((failure) => emit(PopularTvError(failure.message)), (data) {
      data.isEmpty ? emit(PopularTvEmpty()) : emit(PopularTvHasData(data));
    });
  }
}
