import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series_imdb/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_top_rated_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main(){
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc popularTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    popularTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('the initial state should be empty', () {
    expect(popularTvBloc.state, TopRatedTvEmpty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvFetch()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
      return TopRatedTvFetch().props;
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvFetch()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvLoading(),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvFetch()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvEmpty(),
    ],
  );
}