import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/failure.dart'; 
import 'package:tv_series_imdb/domain/usecases/get_popular_tv.dart';
import 'package:tv_series_imdb/presentation/bloc/popular_tv/popular_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main(){
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('the initial state should be empty', () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTvFetch()),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
      return PopularTvFetch().props;
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTvFetch()),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
    verify: (bloc) => PopularTvLoading(),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTvFetch()),
    expect: () => [
      PopularTvLoading(),
      PopularTvEmpty(),
    ],
  );
}