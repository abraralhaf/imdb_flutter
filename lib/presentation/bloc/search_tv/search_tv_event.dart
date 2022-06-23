part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class onQueryChange extends SearchTvEvent {
  final String query;
  onQueryChange(this.query);

  @override
  List<Object> get props => [query];
}
