import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_package/domain/entities/movie_detail.dart';
import 'package:movie_package/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie_package/presentation/pages/movie_detail_page.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movies_detail_page_test.mocks.dart';
import 'package:flutter/material.dart';

void main() {
  late MockMovieDetailBloc mockmovieDetailbloc;
  late MockMovieRecommendationBloc mockmovieRecommendationBloc;
  late MockMovieWatchlistBloc mockmovieWatchlistBloc;

  MovieDetail movieDetail = testMovieDetail;

  var tId = 1;

  setUp(() {
    mockmovieDetailbloc = MockMovieDetailBloc();
    mockmovieRecommendationBloc = MockMovieRecommendationBloc();
    mockmovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (context) => mockmovieDetailbloc),
        BlocProvider<MovieRecommendationBloc>(
            create: (context) => mockmovieRecommendationBloc),
        BlocProvider<MovieWatchlistBloc>(
            create: (context) => mockmovieWatchlistBloc)
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockmovieDetailbloc.close();
    mockmovieRecommendationBloc.close();
    mockmovieWatchlistBloc.close();
  });

  testWidgets('should load loading detail progress bar',
      (WidgetTester tester) async {
    when(mockmovieRecommendationBloc.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationHasData(testMovieList)));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchListIsAdded(true)));

    when(mockmovieWatchlistBloc.state).thenReturn(MovieWatchListIsAdded(true));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieDetailbloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailLoading()));

    when(mockmovieDetailbloc.state).thenReturn(MovieDetailLoading());

    final progressBarFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should load data detail', (WidgetTester tester) async {
    when(mockmovieRecommendationBloc.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationHasData(testMovieList)));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchListIsAdded(true)));

    when(mockmovieWatchlistBloc.state).thenReturn(MovieWatchListIsAdded(true));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieDetailbloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(movieDetail)));

    when(mockmovieDetailbloc.state).thenReturn(MovieDetailHasData(movieDetail));

    final findDetailContent = find.byType(DetailContent);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(findDetailContent, findsOneWidget);
  });

  testWidgets('should load detail data then loading recommendation',
      (WidgetTester tester) async {
    when(mockmovieRecommendationBloc.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationLoading()));

    when(mockmovieRecommendationBloc.state).thenReturn(MovieRecommendationLoading());

    when(mockmovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchListIsAdded(true)));

    when(mockmovieWatchlistBloc.state).thenReturn(MovieWatchListIsAdded(true));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieDetailbloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(movieDetail)));

    when(mockmovieDetailbloc.state).thenReturn(MovieDetailHasData(movieDetail));

    final findCircularLoading = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(findCircularLoading, findsNWidgets(2));
  });

  testWidgets('should load detail data then load recommendation',
      (WidgetTester tester) async {
    when(mockmovieRecommendationBloc.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationHasData(testMovieList)));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchListIsAdded(true)));

    when(mockmovieWatchlistBloc.state).thenReturn(MovieWatchListIsAdded(true));

    when(mockmovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockmovieDetailbloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(movieDetail)));

    when(mockmovieDetailbloc.state).thenReturn(MovieDetailHasData(movieDetail));

    final findListview = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(findListview, findsOneWidget);
  });

}
