import 'package:dartz/dartz.dart';
import 'package:movie_package/common/failure.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
