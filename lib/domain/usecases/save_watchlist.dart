import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlist {
  final TvRepository _repository;

  SaveWatchlist(this._repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _repository.saveWatchlist(tv);
  }
}
