import 'package:dartz/dartz.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repo;

  GetTopRatedTv(this.repo);

  Future<Either<Failure, List<Tv>>> execute() {
    return repo.getTopRatedTv();
  }
}
