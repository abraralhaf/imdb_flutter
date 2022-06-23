import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/domain/entities/genre.dart';
import 'package:tv_series_imdb/domain/entities/tv_detail.dart';

class MyFlexibleAppBar extends StatelessWidget {
  final double appBarHeight = 60.0;
  final TvDetail tvDetail;
  const MyFlexibleAppBar({required this.tvDetail});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: SizedBox(
        height: 200,
        width: 130,
        child: Stack(
          children: [
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              height: 230,
              fit: BoxFit.fill,
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${tvDetail.backdropPath}',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
                padding: const EdgeInsets.all(18.0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.black.withAlpha(0),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7)
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tvDetail.name.toString(),
                      style: kHeading3,
                    ),
                    SizedBox(height: 4),
                    Text(_showGenres(tvDetail.genres),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    SizedBox(height: 16),
                    Text(
                      '${tvDetail.popularity} Popularity',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) {
                              return Icon(
                                IconlyBold.star,
                                size: 12,
                                color: index < (tvDetail.voteAverage / 2)
                                    ? kYellow
                                    : Colors.white.withOpacity(0.5),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '(${tvDetail.voteAverage})',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: kYellowDark),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
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
}
