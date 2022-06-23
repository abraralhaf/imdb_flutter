import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_imdb/presentation/pages/search_tv_page.dart';
import 'search_tv_page_test.mocks.dart';

@GenerateMocks([SearchTvBloc])
void main() {
  late MockSearchTvBloc mockSearchTvBloc;
  final tTvModel = Tv(
      adult: false,
      backdropPath: '/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
      firstAirDate: '2016-07-15',
      genreIds: [10765, 18, 9648],
      homepage: 'homepage',
      id: 66732,
      inProduction: false,
      lastAirDate: 'lastAirDate',
      name: 'Stranger Things',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalLanguage: 'en',
      originalName: 'Stranger Things',
      overview:
          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
      popularity: 3118.667,
      posterPath: '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 8.6,
      voteCount: 10865);
  final tTvList = <Tv>[tTvModel];
  setUp(() {
    mockSearchTvBloc = MockSearchTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>(
      create: (context) => mockSearchTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Search Tv', () {
    testWidgets('should change state to loading when usecase is called',
        (WidgetTester tester) async {
      when(mockSearchTvBloc.stream)
          .thenAnswer((_) => Stream.value(SearchLoading()));
      when(mockSearchTvBloc.state).thenReturn(SearchLoading());

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
