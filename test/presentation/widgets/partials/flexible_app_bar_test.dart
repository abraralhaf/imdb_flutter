import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/domain/entities/season.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/domain/usecases/get_detail_tv.dart';
import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/widgets/partials/flexible_app_bar.dart';
import 'package:tv_series_imdb/presentation/widgets/season_list.dart';
import 'package:mockito/annotations.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../bloc/tv_detail/tv_detail_bloc_test.mocks.dart';
import 'flexible_app_bar_test.mocks.dart';

@GenerateMocks([DetailTvBloc])
void main() {
  late MockDetailTvBloc _mock;

  setUp(() {
    _mock = MockDetailTvBloc();
  });

  TvDetail tvDetail = testTvDetail;
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailTvBloc>(
      create: (context) => _mock,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should render widget', (WidgetTester tester) async {
    when(_mock.stream).thenAnswer(
        (realInvocation) => Stream.value(DetailTvHasData(tvDetail)));

    when(_mock.state).thenReturn(DetailTvHasData(tvDetail));

    final findContainer = find.byType(CachedNetworkImage);

    await tester
        .pumpWidget(_makeTestableWidget(MyFlexibleAppBar(tvDetail: tvDetail)));

    expect(findContainer, findsOneWidget);
  });
}
