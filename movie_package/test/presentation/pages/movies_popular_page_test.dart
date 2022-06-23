import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';
import 'package:movie_package/presentation/pages/popular_movies_page.dart';
import 'movies_popular_page_test.mocks.dart';

@GenerateMocks([MoviePopularBloc])
void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUp(() {
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (context) => mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularLoading()));
    when(mockMoviePopularBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Should display listView when data is loaded',
      (WidgetTester tester) async {
    final tvList = <Movie>[];
    when(mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularHasData(tvList)));
    when(mockMoviePopularBloc.state).thenReturn(MoviePopularHasData(tvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Should add notification message when data Error',
      (WidgetTester tester) async {
    when(mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularError('error message')));
    when(mockMoviePopularBloc.state)
        .thenReturn(MoviePopularError('error message'));

    final textFinder = find.byKey(const Key('error message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  tearDown(() {
    mockMoviePopularBloc.close();
  });
}
