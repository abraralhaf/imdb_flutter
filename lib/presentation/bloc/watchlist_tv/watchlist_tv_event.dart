part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class WatchlistTvFetch extends WatchlistTvEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WatchlistTvStatus extends WatchlistTvEvent {
  final int id;
  WatchlistTvStatus(this.id);

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class WatchlistTvAdd extends WatchlistTvEvent {
  final TvDetail tvDetail;

  WatchlistTvAdd(this.tvDetail);

  @override
  // TODO: implement props
  List<Object> get props => [tvDetail];
}


class WatchlistTvRemove extends WatchlistTvEvent {
  final TvDetail _tvDetail;

  WatchlistTvRemove(this._tvDetail);

  @override
  // TODO: implement props
  List<Object> get props => [_tvDetail];
}
