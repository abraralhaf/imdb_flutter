import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/presentation/widgets/tv_card_2.dart';

import '../../dummy_data/dummy_objects.dart';
import '../pages/detail_tv_page_test.mocks.dart';

void main() {
  Tv dataTv = testTv;

  
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('should render widget', (WidgetTester tester) async {
    final findCard = find.byType(Expanded);

    await tester.pumpWidget(_makeTestableWidget(TvCardV2(dataTv)));

    expect(findCard, findsNWidgets(2));
  });

  testWidgets('should load data on widget', (WidgetTester tester) async {
    final findText = find.text(dataTv.name.toString());

    await tester.pumpWidget(_makeTestableWidget(TvCardV2(dataTv)));

    expect(findText, findsOneWidget);
  });
}
