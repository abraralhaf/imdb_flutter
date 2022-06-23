
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/usecases/get_now_playing_tv.dart';
import 'package:tv_series_imdb/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_now_playing_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingTv])
void main(){
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late NowPlayingTvBloc nowPlayingTvBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingTvBloc.state, NowPlayingTvEmpty());
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingFetchTv()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
      return NowPlayingFetchTv().props;
    },
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingFetchTv()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvLoading(),
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingFetchTv()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvEmpty(),
    ],
  );
}