part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationError extends MovieRecommendationState {
  String message;

  MovieRecommendationError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends MovieRecommendationState {
  List<Movie> result;
  MovieRecommendationHasData(this.result);

  @override
  // TODO: implement props
  List<Object> get props => [result];
}
