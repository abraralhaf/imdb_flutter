import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series_imdb/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series_imdb/domain/usecases/remove_watchlist.dart';
import 'package:tv_series_imdb/domain/usecases/save_watchlist.dart';
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistTv, GetWatchListStatus, RemoveWatchList, SaveWatchlist])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockRemoveWatchList mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchList();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistStatus,
        mockGetWatchlistTv, mockRemoveWatchlist, mockSaveWatchlist);
  });
  test('The initial state should be initial state', () {
    expect(watchlistTvBloc.state, WatchlistTvInitial());
  });

  group(
    'Get watchlist Popular',
    () {
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit loading state and when hasdata state watchlist data succefully',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right([testWatchlistTv]));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistTvFetch()),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvHasData([testWatchlistTv]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
          return WatchlistTvFetch().props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit loading state and when error state data watchlist should be failed',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right([testWatchlistTv]));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistTvFetch()),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvHasData([testWatchlistTv]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
          return WatchlistTvFetch().props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit loading state and when empty state data watchlist should be empty',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistTvFetch()),
        expect: () => [WatchlistTvLoading(), WatchlistTvEmpty()],
      );
    },
  );

  group(
    'Get watchlist status',
    () {
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistTvStatus(testTvDetail.id)),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
          return WatchlistTvStatus(testTvDetail.id).props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistTvStatus(testTvDetail.id)),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
          return WatchlistTvStatus(testTvDetail.id).props;
        },
      );
    },
  );

  group('Add and remove watchlist test case', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should update watchlist state when adding watchlist successful',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right("Successfully"));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvAdd(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasMessage("Successfully")],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTvDetail));
        return WatchlistTvAdd(testTvDetail).props;
      },
    );
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should throw failure message status when adding watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvAdd(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Failed'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTvDetail));
        return WatchlistTvAdd(testTvDetail).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should update watchlist status when removing watchlist success',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right("Removed"));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvRemove(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasMessage("Removed"),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testTvDetail));
        return WatchlistTvRemove(testTvDetail).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should throw failure message status when removing watchlist failure',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvRemove(testTvDetail)),
      expect: () => [WatchlistTvLoading(), WatchlistTvError('Failed')],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testTvDetail));
        return WatchlistTvRemove(testTvDetail).props;
      },
    );
  });
}
