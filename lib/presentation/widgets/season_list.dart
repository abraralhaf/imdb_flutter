import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/domain/entities/season.dart';
import 'package:tv_series_imdb/presentation/pages/detail_tv_page.dart';

class SeasonList extends StatelessWidget {
  final List<Season> list;

  SeasonList(this.list);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final result = list[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      height: 75,
                      fit: BoxFit.fitHeight,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${result.poster_path}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result.name, style: kTitlesmall),
                      SizedBox(height: 3),
                      Text('Total eps: ${result.episode_count}',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text(
                          result.overview == ""
                              ? "Sorry, overview was empty or not filled by system"
                              : result.overview,
                          style: kBodyText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
