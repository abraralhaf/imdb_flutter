import 'package:dartz/dartz.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/domain/repositories/movie_repository.dart';
import 'package:movie_package/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
