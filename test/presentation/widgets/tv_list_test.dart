import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/presentation/widgets/tv_list.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  List<Tv> _listTv = testTvList;

  testWidgets('should load list data tv when success',
      (WidgetTester tester) async {
    final listviewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(TvList(_listTv)));

    expect(listviewFinder, findsOneWidget);
  });
}
