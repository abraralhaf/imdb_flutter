import 'package:equatable/equatable.dart';
import 'package:tv_series_imdb/data/models/tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvList;

  TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.backdropPath != null && element.posterPath != null) ),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

      @override
  // TODO: implement props
  List<Object?> get props => [tvList];
}
