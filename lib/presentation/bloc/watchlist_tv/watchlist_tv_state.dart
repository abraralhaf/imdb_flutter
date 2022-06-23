part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  String message;
  WatchlistTvError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> result;
  WatchlistTvHasData(this.result);
  @override
  List<Object> get props => [result];
}

class WatchlistTvHasMessage extends WatchlistTvState {
  final String message;

  WatchlistTvHasMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvIsAdded extends WatchlistTvState {
  final bool isAdded;

  WatchlistTvIsAdded(this.isAdded);
  @override
  // TODO: implement props
  List<Object> get props => [isAdded];
}
