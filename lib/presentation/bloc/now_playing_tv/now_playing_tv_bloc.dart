import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_now_playing_tv.dart';

import 'package:rxdart/rxdart.dart';
part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _getNowPlayingTv;

  NowPlayingTvBloc(this._getNowPlayingTv) : super(NowPlayingTvEmpty()) {
    on<NowPlayingFetchTv>(_onNowPlayingFetch);
  }

  void _onNowPlayingFetch(
      NowPlayingFetchTv event, Emitter<NowPlayingTvState> emit) async {
    emit(NowPlayingTvLoading());
    final result = await _getNowPlayingTv.execute();

    result.fold((failure) {
      emit(NowPlayingTvError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(NowPlayingTvEmpty())
          : emit(NowPlayingTvHasData(data));
    });
  }
}
