import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_package/common/utils.dart';
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie_package/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistMoviesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieWatchlistBloc>().add(FetchMovieWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(
        () => context.read<MovieWatchlistBloc>().add(FetchMovieWatchList()));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movie'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
              builder: (context, state) {
            if (state is MovieWatchListLoading) {
              print('loading');
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieWatchListHasData) {
              print('loaded');
              final data = state.result;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return MovieCard(movie);
                },
              );
            } else if (state is MovieWatchListEmpty) {
              print('empty');
              return const Center(
                child: Text("Watchlist Empty"),
              );
            } else {
              return const Center(
                key: Key("error_message"),
                child: Text("Failed"),
              );
            }
          }),
        ),
      ),
    );
  }
}
