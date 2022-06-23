import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:movie_package/domain/entities/movie_detail.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/domain/usecases/get_detail_tv.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetDetailTv _getDetailTv;
  DetailTvBloc(this._getDetailTv) : super(DetailTvEmpty()) {
    on<DetailTvFetch>(_onDetailTvFetch);
  }

  FutureOr<void> _onDetailTvFetch(
      DetailTvFetch event, Emitter<DetailTvState> emit) async {
    emit(DetailTvLoading());
    final id = event.id;

    final result = await _getDetailTv.execute(id);
    result.fold((failure) {
      emit(DetailTvError(failure.message));
    }, (data) {
      emit(DetailTvHasData(data));
    });
  }
}
