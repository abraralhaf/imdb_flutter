import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_tv_recommendations.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(this._getTvRecommendations)
      : super(RecommendationTvEmpty()) {
    on<RecommendationTvFetch>(_onRecommendationTvFetch);
  }

  FutureOr<void> _onRecommendationTvFetch(
      RecommendationTvFetch event, Emitter<RecommendationTvState> emit) async {
    emit(RecommendationTvLoading());
    final id = event.id;

    final result = await _getTvRecommendations.execute(id);
    result.fold((failure) {
      emit(RecommendationTvError(failure.message));
    }, (data) => emit(RecommendationTvHasData(data)));
  }
}
