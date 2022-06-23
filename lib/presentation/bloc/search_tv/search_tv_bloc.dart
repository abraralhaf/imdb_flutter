import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/search_tv.dart';
import 'package:rxdart/rxdart.dart';
part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTv;

  SearchTvBloc(this._searchTv) : super(SearchEmpty()) {
    on<onQueryChange>(
      (event, emit) async {
        final query = event.query;
        emit(SearchLoading());
        final result = await _searchTv.execute(query);

        result.fold((failure) => emit(SearchError(failure.message)),
            (data) => emit(SearchHasData(data)));
      }, transformer: debounce(const Duration(microseconds: 500))
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
