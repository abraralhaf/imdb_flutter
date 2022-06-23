import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([PopularTvBloc])
void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (context) => mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Should display listView when data is loaded',
      (WidgetTester tester) async {
    final tvList = <Tv>[];
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvHasData(tvList)));
    when(mockPopularTvBloc.state).thenReturn(PopularTvHasData(tvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Should add notification message when data Error',
      (WidgetTester tester) async {
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value( PopularTvError('Error message')));
    when(mockPopularTvBloc.state).thenReturn( PopularTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });

  tearDown(() {
    mockPopularTvBloc.close();
  });
}
