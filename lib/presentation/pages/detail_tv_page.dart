import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/common/state_enum.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';
import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/recommendation_tv/bloc/recommendation_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/widgets/partials/flexible_app_bar.dart';

import 'package:provider/provider.dart';
import 'package:tv_series_imdb/presentation/widgets/season_list.dart';

class DetailTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';
  final int id;
  DetailTvPage({required this.id});
  @override
  State<DetailTvPage> createState() => _DetailTvPageState();
}

class _DetailTvPageState extends State<DetailTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(DetailTvFetch(widget.id));
      context
          .read<RecommendationTvBloc>()
          .add(RecommendationTvFetch(widget.id));
      context.read<WatchlistTvBloc>().add(WatchlistTvStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Tv> recommendations;
    var isWatch = context.select<WatchlistTvBloc, bool>((bloc) {
      if (bloc.state is WatchlistTvIsAdded) {
        return (bloc.state as WatchlistTvIsAdded).isAdded;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailTvState>(
        builder: (context, state) {
          if (state is DetailTvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvHasData) {
            final tv = state.result;

            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    pinned: true,
                    title: Text(
                      tv.name.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: IconButton(
                      icon: Icon(IconlyLight.arrow_left, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: kExoticBlack,
                    expandedHeight: 230,
                    flexibleSpace: FlexibleSpaceBar(
                      background: MyFlexibleAppBar(tvDetail: tv),
                    )),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Overview', style: kBodyText),
                            _watchlistButton(isWatch: isWatch, tv: tv),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          tv.overview.toString(),
                          style: kSubtitle,
                        ),
                        SizedBox(height: 22),
                        Text('Reccomendation', style: kBodyText),
                        SizedBox(height: 16),
                        BlocBuilder<RecommendationTvBloc,
                            RecommendationTvState>(builder: (context, state) {
                          if (state is RecommendationTvLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is RecommendationTvError) {
                            return Text(state.message);
                          } else if (state is RecommendationTvHasData) {
                            return Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  print(state.result);
                                  List<Tv> recommendations = state.result;
                                  final recTv = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          DetailTvPage.ROUTE_NAME,
                                          arguments: recTv.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${recTv.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: state.result.length,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                        SizedBox(height: 18),
                        Text('Season', style: kBodyText),
                        SizedBox(height: 8),
                        Container(height: 330, child: SeasonList(tv.seasons)),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state is DetailTvError) {
            return Text(state.message);
          } else {
            return Center(
              child: Text('Failure'),
            );
          }
        },
      ),
    );
  }
}

class _watchlistButton extends StatefulWidget {
  _watchlistButton({
    Key? key,
    required this.isWatch,
    required this.tv,
  }) : super(key: key);

  bool isWatch;
  final TvDetail tv;

  @override
  State<_watchlistButton> createState() => _watchlistButtonState();
}

class _watchlistButtonState extends State<_watchlistButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        if (!widget.isWatch) {
          context.read<WatchlistTvBloc>().add(WatchlistTvAdd(widget.tv));
          print('CHECK ${widget.isWatch}');
        } else {
          context.read<WatchlistTvBloc>().add(WatchlistTvRemove(widget.tv));
          print('CHECK ${widget.isWatch}');
        }
        final stateMessage = BlocProvider.of<WatchlistTvBloc>(context).state;
        String message = '';
        String messageAdded = "Added Watchlist";
        String messageRemoved = "Removed Watchlist";
        if (stateMessage is WatchlistTvIsAdded) {
          message = stateMessage.isAdded == false ? messageAdded : messageRemoved;
        } else {
          message = !widget.isWatch ? messageAdded : messageRemoved;
        }
        if (message == messageAdded || message == messageRemoved) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              });
        }
        setState(() {
          widget.isWatch = !widget.isWatch;
        });
      },
      icon: Icon(
        IconlyBold.play,
        color: widget.isWatch ? kPastelRed : kExoticBlack,
        size: 12,
      ),
      label: Text(
        widget.isWatch ? 'Remove watchlist' : 'Add watchlist',
        style:
            TextStyle(fontSize: 12, color: Colors.black87, letterSpacing: 0.5),
      ),
    );
  }
}
