import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_package/common/failure.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/domain/usecases/search_movies.dart';
import 'package:movie_package/presentation/bloc/movie_search/movie_search_bloc.dart';

import 'movie_search_bloc_test.mocks.dart';
@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = MovieSearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, MovieSearchEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

blocTest<MovieSearchBloc, MovieSearchState>(
  'Should emit [Loading, HasData] when data is gotten successfully',
  build: () {
    when(mockSearchMovies.execute(tQuery))
        .thenAnswer((_) async => Right(tMovieList));
    return searchBloc;
  },
  act: (bloc) => bloc.add(onQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    MovieSearchLoading(),
    MovieSearchHasData(tMovieList),
  ],
  verify: (bloc) {
    verify(mockSearchMovies.execute(tQuery));
  },
);
  blocTest<MovieSearchBloc, MovieSearchState>(
      'Should emit [loading, error] when get search is unsuccessfull',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(onQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            MovieSearchLoading(),
            MovieSearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      });
}
