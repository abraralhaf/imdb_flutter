import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_package/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/usecases/get_detail_tv.dart';
import 'package:tv_series_imdb/domain/usecases/search_tv.dart';
import 'package:tv_series_imdb/presentation/bloc/search_tv/search_tv_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main(){
  late SearchTvBloc searchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchBloc = SearchTvBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

   final tTvModel = Tv(
      adult: false,
      backdropPath: '/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
      firstAirDate: '2016-07-15',
      genreIds: [10765, 18, 9648],
      homepage: 'homepage',
      id: 66732,
      inProduction: false,
      lastAirDate: 'lastAirDate',
      name: 'Stranger Things',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalLanguage: 'en',
      originalName: 'Stranger Things',
      overview:
          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
      popularity: 3118.667,
      posterPath: '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 8.6,
      voteCount: 10865);
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'Stranger';


blocTest<SearchTvBloc, SearchTvState>(
  'Should emit [Loading, HasData] when data is gotten successfully',
  build: () {
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    return searchBloc;
  },
  act: (bloc) => bloc.add(onQueryChange(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    SearchLoading(),
    SearchHasData(tTvList),
  ],
  verify: (bloc) {
    verify(mockSearchTv.execute(tQuery));
  },
);
  blocTest<SearchTvBloc, SearchTvState>(
      'Should emit [loading, error] when get search is unsuccessfull',
      build: () {
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(onQueryChange(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchLoading(),
            SearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      });
}