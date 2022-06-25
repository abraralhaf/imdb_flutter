import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/recommendation_tv/bloc/recommendation_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_imdb/presentation/pages/detail_tv_page.dart';
import 'package:tv_series_imdb/presentation/widgets/season_list.dart';
import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_page_test.mocks.dart';

@GenerateMocks([DetailTvBloc, RecommendationTvBloc, WatchlistTvBloc])
void main() {
  late MockDetailTvBloc _mockDetailTvBloc;
  late MockRecommendationTvBloc _mockRecommendationTvBloc;
  late MockWatchlistTvBloc _mockWatchlistBloc;

  TvDetail tvDetail = testTvDetail;
  var tId = 1;
  setUp(() {
    _mockDetailTvBloc = MockDetailTvBloc();
    _mockRecommendationTvBloc = MockRecommendationTvBloc();
    _mockWatchlistBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(create: (context) => _mockDetailTvBloc),
        BlocProvider<RecommendationTvBloc>(
            create: (context) => _mockRecommendationTvBloc),
        BlocProvider<WatchlistTvBloc>(create: (context) => _mockWatchlistBloc)
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    _mockRecommendationTvBloc.close();
    _mockWatchlistBloc.close();
    _mockDetailTvBloc.close();
  });
  testWidgets('should load loading detail progress bar',
      (WidgetTester tester) async {
    when(_mockRecommendationTvBloc.stream)
        .thenAnswer((_) => Stream.value(RecommendationTvHasData(testTvList)));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvIsAdded(true)));

    when(_mockWatchlistBloc.state).thenReturn(WatchlistTvIsAdded(true));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockDetailTvBloc.stream)
        .thenAnswer((_) => Stream.value(DetailTvLoading()));

    when(_mockDetailTvBloc.state).thenReturn(DetailTvLoading());

    final progressBarFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: tId)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should load data detail', (WidgetTester tester) async {
    when(_mockRecommendationTvBloc.stream)
        .thenAnswer((_) => Stream.value(RecommendationTvHasData(testTvList)));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvIsAdded(true)));

    when(_mockWatchlistBloc.state).thenReturn(WatchlistTvIsAdded(true));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockDetailTvBloc.stream)
        .thenAnswer((_) => Stream.value(DetailTvHasData(tvDetail)));

    when(_mockDetailTvBloc.state).thenReturn(DetailTvHasData(tvDetail));

    final findSliverToBoxAdapter = find.byType(SliverToBoxAdapter);

    await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: tId)));

    expect(findSliverToBoxAdapter, findsOneWidget);
  });

  testWidgets('should load detail data then loading recommendation',
      (WidgetTester tester) async {
    when(_mockRecommendationTvBloc.stream)
        .thenAnswer((_) => Stream.value(RecommendationTvLoading()));

    when(_mockRecommendationTvBloc.state).thenReturn(RecommendationTvLoading());

    when(_mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvIsAdded(true)));

    when(_mockWatchlistBloc.state).thenReturn(WatchlistTvIsAdded(true));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockDetailTvBloc.stream)
        .thenAnswer((_) => Stream.value(DetailTvHasData(tvDetail)));

    when(_mockDetailTvBloc.state).thenReturn(DetailTvHasData(tvDetail));

    final findCircularLoading = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: tId)));

    expect(findCircularLoading, findsNWidgets(3));
  });


  
  testWidgets('should load detail data then load recommendation',
      (WidgetTester tester) async {
    when(_mockRecommendationTvBloc.stream)
        .thenAnswer((_) => Stream.value(RecommendationTvHasData(testTvList)));

    when(_mockRecommendationTvBloc.state).thenReturn(RecommendationTvHasData(testTvList));

    when(_mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvIsAdded(true)));

    when(_mockWatchlistBloc.state).thenReturn(WatchlistTvIsAdded(true));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockDetailTvBloc.stream)
        .thenAnswer((_) => Stream.value(DetailTvHasData(tvDetail)));

    when(_mockDetailTvBloc.state).thenReturn(DetailTvHasData(tvDetail));

    final findListview = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: tId)));

    expect(findListview, findsNWidgets(2));
  });

  
  testWidgets('should load seasons  detail data ',
      (WidgetTester tester) async {
    when(_mockRecommendationTvBloc.stream)
        .thenAnswer((_) => Stream.value(RecommendationTvHasData(testTvList)));

    when(_mockRecommendationTvBloc.state).thenReturn(RecommendationTvHasData(testTvList));

    when(_mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvIsAdded(true)));

    when(_mockWatchlistBloc.state).thenReturn(WatchlistTvIsAdded(true));

    when(_mockRecommendationTvBloc.state)
        .thenReturn(RecommendationTvHasData(testTvList));

    when(_mockDetailTvBloc.stream)
        .thenAnswer((_) => Stream.value(DetailTvHasData(tvDetail)));

    when(_mockDetailTvBloc.state).thenReturn(DetailTvHasData(tvDetail));

    final loadseason = find.byType(SeasonList);

    await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: tId)));

    expect(loadseason, findsOneWidget);
  });
  
}
