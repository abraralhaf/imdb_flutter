import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_package/common/failure.dart';
import 'package:movie_package/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_package/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_package/domain/usecases/get_watchlist_status.dart';
import 'package:movie_package/domain/usecases/remove_watchlist.dart';
import 'package:movie_package/domain/usecases/save_watchlist.dart';
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, RemoveWatchlist, SaveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(mockGetWatchlistMovies,
        mockGetWatchListStatus, mockRemoveWatchlist, mockSaveWatchlist);
  });
  test('The initial state should be initial state', () {
    expect(movieWatchlistBloc.state, MovieWatchlistInitial());
  });

  group(
    'Get watchlist movies',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit loading state and when hasdata state watchlist data succefully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(FetchMovieWatchList()),
        expect: () => [
          MovieWatchListLoading(),
          MovieWatchListHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
          return FetchMovieWatchList().props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit loading state and when error state data watchlist should be failed',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(FetchMovieWatchList()),
        expect: () => [
          MovieWatchListLoading(),
          MovieWatchListHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
          return FetchMovieWatchList().props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit loading state and when empty state data watchlist should be empty',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(FetchMovieWatchList()),
        expect: () => [MovieWatchListLoading(), MovieWatchListEmpty()],
      );
    },
  );

  group(
    'Get watchlist status',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListStatus(testMovieDetail.id)),
        expect: () => [
          MovieWatchListIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return MovieWatchListStatus(testMovieDetail.id).props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListStatus(testMovieDetail.id)),
        expect: () => [
          MovieWatchListIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return MovieWatchListStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group('Add and remove watchlist test case', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should update watchlist state when adding watchlist successful',
      build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("Successfully"));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(MovieWatchListAdd(testMovieDetail)),
      expect: () => [MovieWatchListMessage("Successfully")],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return MovieWatchListAdd(testMovieDetail).props;
      },
    );
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should throw failure message status when adding watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(MovieWatchListAdd(testMovieDetail)),
      expect: () => [
        MovieWatchListError('Failed'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return MovieWatchListAdd(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should update watchlist status when removing watchlist success',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("Removed"));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(MovieWatchListRemove(testMovieDetail)),
      expect: () => [
        MovieWatchListMessage("Removed"),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return MovieWatchListRemove(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should throw failure message status when removing watchlist failure',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(MovieWatchListRemove(testMovieDetail)),
      expect: () => [MovieWatchListError('Failed')],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return MovieWatchListRemove(testMovieDetail).props;
      },
    );
  });
}
