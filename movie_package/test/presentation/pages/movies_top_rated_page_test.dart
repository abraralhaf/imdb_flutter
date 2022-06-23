import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie_package/presentation/pages/top_rated_movies_page.dart';

import '../bloc/movie_top_rated/movie_top_rated_bloc_test.mocks.dart';
import 'movies_top_rated_page_test.mocks.dart';
import 'package:flutter/material.dart';

@GenerateMocks([MovieTopRatedBloc])
void main() {
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUp(() {
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (context) => mockMovieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedLoading()));
    when(mockMovieTopRatedBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Should display listView when data is loaded',
      (WidgetTester tester) async {
    final movieList = <Movie>[];
    when(mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedHasData(movieList)));
    when(mockMovieTopRatedBloc.state)
        .thenReturn(MovieTopRatedHasData(movieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Should add notification message when data Error',
      (WidgetTester tester) async {
    when(mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedError('error_message')));
    when(mockMovieTopRatedBloc.state)
        .thenReturn(MovieTopRatedError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  tearDown(() {
    mockMovieTopRatedBloc.close();
  });
}
