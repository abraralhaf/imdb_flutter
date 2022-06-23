import 'package:dartz/dartz.dart';
import 'package:movie_package/common/failure.dart';
import 'package:movie_package/domain/entities/movie_detail.dart';
import 'package:movie_package/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
