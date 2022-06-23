part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchListEmpty extends MovieWatchlistState {}

class MovieWatchListLoading extends MovieWatchlistState {}

class MovieWatchListError extends MovieWatchlistState {
  final String message;

  MovieWatchListError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class MovieWatchListHasData extends MovieWatchlistState {
  final List<Movie> result;

  MovieWatchListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchListIsAdded extends MovieWatchlistState {
  final bool isAdded;

  MovieWatchListIsAdded(this.isAdded);

  @override
  // TODO: implement props
  List<Object> get props => [isAdded];
}

class MovieWatchListMessage extends MovieWatchlistState {
  final String message;

  MovieWatchListMessage(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
