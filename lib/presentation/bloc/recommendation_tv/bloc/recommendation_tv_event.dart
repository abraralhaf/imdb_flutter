part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

  @override
  List<Object> get props => [];
}

class RecommendationTvFetch extends RecommendationTvEvent {
  final int id;
  RecommendationTvFetch(this.id);

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
