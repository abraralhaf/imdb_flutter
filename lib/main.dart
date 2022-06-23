import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_package/presentation/pages/home_movie_page.dart';
import 'package:movie_package/presentation/pages/movie_detail_page.dart';
import 'package:movie_package/presentation/pages/popular_movies_page.dart';
import 'package:movie_package/presentation/pages/top_rated_movies_page.dart';
import 'package:movie_package/presentation/pages/watchlist_movies_page.dart'
    as watchlistMoviePage;
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie_package/presentation/pages/search_page.dart'
    as searchPageMovie;
import 'package:provider/provider.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/common/utils.dart';
import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/recommendation_tv/bloc/recommendation_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/pages/about_page.dart';
import 'package:tv_series_imdb/presentation/pages/detail_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/home_page.dart';
import 'package:tv_series_imdb/injection.dart' as di;
import 'package:tv_series_imdb/presentation/pages/popular_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/search_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/watchlist_tv_page.dart';

import 'package:tv_series_imdb/presentation/bloc/search_tv/search_tv_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //bloc tv
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvBloc>(),
        ),
        //bloc                                  movie
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Imdb Tv',
        theme: ThemeData(
          colorScheme: kColorScheme,
          primaryColor: kYellow,
          fontFamily: GoogleFonts.roboto().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          textTheme: kTextTheme,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.grey,
              elevation: 10,
              unselectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              selectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case SearchPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case PopularTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case DetailTvPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailTvPage(id: id), settings: settings);
            //      MOVIE ROUTE
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case watchlistMoviePage.WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => watchlistMoviePage.WatchlistMoviesPage());
            case searchPageMovie.SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => searchPageMovie.SearchPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
