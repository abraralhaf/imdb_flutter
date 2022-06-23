import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_detail_tv.dart';
import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTv])
void main(){
  late MockGetDetailTv mockGetTvDetail;
  late DetailTvBloc detailTvBloc;

  const tId = 1;

  setUp(() {
    mockGetTvDetail = MockGetDetailTv();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  test('the initial state should be empty', () {
    expect(detailTvBloc.state, DetailTvEmpty());
  });
  blocTest<DetailTvBloc, DetailTvState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(DetailTvFetch(tId)),
    expect: () => [
      DetailTvLoading(),
      DetailTvHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
      return DetailTvFetch(tId).props;
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(DetailTvFetch(tId)),
    expect: () => [
      DetailTvLoading(),
      DetailTvError('Server Failure'),
    ],
    verify: (bloc) => DetailTvLoading(),
  );

}