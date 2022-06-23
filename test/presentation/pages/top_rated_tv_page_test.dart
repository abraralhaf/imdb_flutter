import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_imdb/common/state_enum.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_imdb/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/pages/top_rated_tv_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTvBloc])
void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (context) => mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

    testWidgets('Should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoading()));
    when(mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Should display listView when data is loaded',
      (WidgetTester tester) async {
    final tvList = <Tv>[];
    when(mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvHasData(tvList)));
    when(mockTopRatedTvBloc.state).thenReturn(TopRatedTvHasData(tvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Should add notification message when data Error',
      (WidgetTester tester) async {
    when(mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvError('Error message')));
    when(mockTopRatedTvBloc.state).thenReturn(TopRatedTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });

  tearDown(() {
    mockTopRatedTvBloc.close();
  });
}
