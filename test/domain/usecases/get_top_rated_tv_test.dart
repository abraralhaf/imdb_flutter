import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/repositories/tv_repository.dart';
import 'package:tv_series_imdb/domain/usecases/get_top_rated_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final tTv = <Tv>[];

  test('should get list of Tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv()).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
