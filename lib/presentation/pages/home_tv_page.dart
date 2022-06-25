import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_imdb/common/constants.dart';

import 'package:flutter/material.dart';
import 'package:tv_series_imdb/common/state_enum.dart';
import 'package:tv_series_imdb/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/pages/popular_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/search_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/watchlist_tv_page.dart';
import 'package:tv_series_imdb/presentation/widgets/tv_list.dart';

class HomeTvPage extends StatefulWidget {
  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(NowPlayingFetchTv());
      context.read<TopRatedTvBloc>().add(TopRatedTvFetch());
      context.read<PopularTvBloc>().add(PopularTvFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBixUsScrikked) => [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 1,
              backgroundColor: Colors.white,
              title: Text('TV Series', style: kHeading6),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
                    },
                    icon: Icon(
                      IconlyLight.play,
                      color: kExoticBlack,
                    )),
                IconButton(
                    onPressed: () {
                      //crashlytic
                      // FirebaseCrashlytics.instance.crash();
                      Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                    },
                    icon: Icon(
                      IconlyLight.search,
                      color: kExoticBlack,
                    )),
              ],
            )
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Column(
                children: [
                  //playing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Now Playing', style: kSubtitle),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyLight.arrow_right_2,
                            size: 14,
                            color: kExoticBlack,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 250,
                    child: BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
                        builder: (context, state) {
                      if (state is NowPlayingTvLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NowPlayingTvHasData) {
                        return TvList(state.result);
                      } else if (state is NowPlayingTvError) {
                        return Text(state.message);
                      } else {
                        return Center(
                          child: Text('Failed'),
                        );
                      }
                    }),
                  ),
                  //popular
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Popular', style: kSubtitle),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PopularTvPage.ROUTE_NAME);
                          },
                          icon: Icon(
                            IconlyLight.arrow_right_2,
                            size: 14,
                            color: kExoticBlack,
                          ))
                    ],
                  ),
                  Container(
                    height: 250,
                    child: BlocBuilder<PopularTvBloc, PopularTvState>(
                      builder: (context, state) {
                        if (state is PopularTvLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is PopularTvHasData) {
                          return TvList(state.result);
                        } else if (state is PopularTvError) {
                          return Text(state.message);
                        } else {
                          return Text('Failed');
                        }
                      },
                    ),
                  ),
                  //toprated
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Top Rated', style: kSubtitle),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TopRatedTvPage.ROUTE_NAME);
                          },
                          icon: Icon(
                            IconlyLight.arrow_right_2,
                            size: 14,
                            color: kExoticBlack,
                          ))
                    ],
                  ),
                  Container(
                    height: 250,
                    child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                      builder: (context, state) {
                        if (state is TopRatedTvLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TopRatedTvHasData) {
                          return TvList(state.result);
                        } else if (state is TopRatedTvError) {
                          return Text(state.message);
                        } else {
                          return Text("Failure");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
