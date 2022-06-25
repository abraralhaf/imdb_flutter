import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_imdb/domain/entities/season.dart';
import 'package:tv_series_imdb/presentation/widgets/season_list.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  List<Season> dataSeason = testSeasonsList;

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('should render widget', (WidgetTester tester) async {
    final findListView = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SeasonList(dataSeason)));

    expect(findListView, findsOneWidget);
  });

}
