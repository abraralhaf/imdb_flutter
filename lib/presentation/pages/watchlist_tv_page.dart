import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/common/state_enum.dart';
import 'package:tv_series_imdb/common/utils.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/pages/detail_tv_page.dart';
import 'package:tv_series_imdb/presentation/widgets/tv_card_2.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_tv';
  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvBloc>().add(WatchlistTvFetch()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(WatchlistTvFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                  builder: (context, state) {
                    print(state);
                    if (state is WatchlistTvLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is WatchlistTvHasData) {
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            final tv = state.result[index];
                            return TvCardV2(tv);
                          },
                          itemCount: state.result.length);
                    } else if (state is WatchlistTvError) {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    } else if (state is WatchlistTvEmpty) {
                      return Center(
                        child: Text("Empty Watchlist"),
                      );
                    } else {
                      return Center(
                        child: Text('Failure'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
