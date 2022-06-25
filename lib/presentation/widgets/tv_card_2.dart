import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/presentation/pages/detail_tv_page.dart';

class TvCardV2 extends StatelessWidget {
  final Tv tv;

  TvCardV2(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailTvPage.ROUTE_NAME,
            arguments: tv.id,
          );
        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                    width: 40,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${tv.name}', style: kTitlesmall),
                      Container(
                        margin: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                            tv.overview == ""
                                ? "Sorry, overview was empty or not filled by system"
                                : '${tv.overview}',
                            style: kBodyText,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
