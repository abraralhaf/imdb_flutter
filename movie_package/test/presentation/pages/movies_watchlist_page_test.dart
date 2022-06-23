import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_package/presentation/pages/watchlist_movies_page.dart';
import 'movies_watchlist_page_test.mocks.dart';

@GenerateMocks([MovieWatchlistBloc])
void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>(
      create: (context) => mockMovieWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Watchlist Movie', () {
    testWidgets('Page should display circular progress bar when loading',
        (WidgetTester tester) async {
      when(mockMovieWatchlistBloc.stream)
          .thenAnswer((_) => Stream.value(MovieWatchListLoading()));
      when(mockMovieWatchlistBloc.state).thenReturn(MovieWatchListLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display Data when data is loaded',
        (WidgetTester tester) async {
      final movieList = <Movie>[];
      when(mockMovieWatchlistBloc.stream)
          .thenAnswer((_) => Stream.value(MovieWatchListHasData(movieList)));

      when(mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchListHasData(movieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when error',
        (WidgetTester tester) async {
      when(mockMovieWatchlistBloc.stream).thenAnswer(
          (_) => Stream.value(MovieWatchListError('Error message')));
      when(mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchListError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
