import 'package:dartz/dartz.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/domain/repositories/tv_repository.dart';

class GetDetailTv {
  final TvRepository repo;

  GetDetailTv(this.repo);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repo.getTvDetail(id);
  }
}
