import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_package/common/constants.dart';
import 'package:movie_package/domain/entities/genre.dart';
import 'package:movie_package/domain/entities/movie.dart';
import 'package:movie_package/domain/entities/movie_detail.dart';
import 'package:movie_package/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_package/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_movie';

  final int id;

  MovieDetailPage({required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
 @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id)); 
      context
          .read<MovieRecommendationBloc>()
          .add(FetchMovieRecommendation(widget.id));
      context.read<MovieWatchlistBloc>().add(MovieWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieAddedToWatchList =
        context.select<MovieWatchlistBloc, bool>((bloc) {
      if (bloc.state is MovieWatchListIsAdded) {
        return (bloc.state as MovieWatchListIsAdded).isAdded;
      } else {
        return false;
      }
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            print(state);
            if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailHasData) {
              final movie = state.result;
              return DetailContent(
                  movie: movie,
                  isAddedWatchlist: isMovieAddedToWatchList,
               
              );
            } else if (state is MovieDetailError) {
              return Text(state.message);
            } else {
              return Text("Failure");
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
 final MovieDetail movie;
  bool isAddedWatchlist;

  DetailContent({Key? key, required this.movie, required this.isAddedWatchlist}) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(MovieWatchListAdd(widget.movie));
                                } else {
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(MovieWatchListRemove(widget.movie));
                                }
                                final stateMessage =
                                    BlocProvider.of<MovieWatchlistBloc>(context)
                                        .state;
                                String message = "";
                                String messageAdded = "Added Watchlist";
                                String messageRemoved = "Removed Watchlist";
                                if (stateMessage is MovieWatchListIsAdded) {
                                  message = stateMessage.isAdded == false
                                      ? messageAdded
                                      : messageRemoved;
                                } else {
                                  message = !widget.isAddedWatchlist
                                      ? messageAdded
                                      : messageRemoved;
                                }
                                if (message == messageAdded ||
                                    message == messageRemoved) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
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
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationBloc,
                                MovieRecommendationState>(
                              builder: (context, state) {
                                if (state is MovieRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                    is MovieRecommendationHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
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
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.grey[500],
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.read<MovieWatchlistBloc>().add(FetchMovieWatchList());
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
