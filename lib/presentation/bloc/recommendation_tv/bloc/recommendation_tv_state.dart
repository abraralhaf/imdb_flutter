part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();

  @override
  List<Object> get props => [];
}

class RecommendationTvEmpty extends RecommendationTvState {}

class RecommendationTvLoading extends RecommendationTvState {}

class RecommendationTvError extends RecommendationTvState {
  String message;

  RecommendationTvError(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class RecommendationTvHasData extends RecommendationTvState {
  List<Tv> result;

  RecommendationTvHasData(this.result);
  @override
  // TODO: implement props
  List<Object> get props => [result];
}
