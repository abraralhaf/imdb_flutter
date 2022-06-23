import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series_imdb/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series_imdb/domain/usecases/remove_watchlist.dart';
import 'package:tv_series_imdb/domain/usecases/save_watchlist.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListStatus _getWatchListStatus;
  final GetWatchlistTv _getWatchlistTv;
  final RemoveWatchList _removeWatchList;
  final SaveWatchlist _saveWatchlist;

  WatchlistTvBloc(this._getWatchListStatus, this._getWatchlistTv,
      this._removeWatchList, this._saveWatchlist)
      : super(WatchlistTvInitial()) {
    on<WatchlistTvFetch>(_watchlistTvFetch);
    on<WatchlistTvStatus>(_watchlistTvStatus);
    on<WatchlistTvAdd>(_watchlistTvAdd);
    on<WatchlistTvRemove>(_watchlistTvRemove);
  }

  FutureOr<void> _watchlistTvFetch(
      WatchlistTvFetch event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoading());
    final result = await _getWatchlistTv.execute();

    result.fold((failure) {
      emit(WatchlistTvError(failure.message));
    }, (data) {
      data.isEmpty ? emit(WatchlistTvEmpty()) : emit(WatchlistTvHasData(data));
    });
  }

  FutureOr<void> _watchlistTvStatus(
      WatchlistTvStatus event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoading());
    final result = await _getWatchListStatus.execute(event.id);
    emit(WatchlistTvIsAdded(result));
  }

  FutureOr<void> _watchlistTvAdd(
      WatchlistTvAdd event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoading());
    final result = await _saveWatchlist.execute(event.tvDetail);
    result.fold((failure) {
      emit(WatchlistTvError(failure.message));
    }, (data) {
      emit(WatchlistTvHasMessage(data));
    });
  }

  FutureOr<void> _watchlistTvRemove(
      WatchlistTvRemove event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoading());
    final result = await _removeWatchList.execute(event._tvDetail);
    result.fold((failure) {
      emit(WatchlistTvError(failure.message));
    }, (data) {
      emit(WatchlistTvHasMessage(data));
    });
  }
}
