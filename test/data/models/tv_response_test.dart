import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_imdb/data/models/tv_model.dart';
import 'package:tv_series_imdb/data/models/tv_response.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      adult: false,
      backdropPath: '/path.jpg',
      firstAirDate: 'firstAirDate',
      genreIds: [1, 2, 3, 4],
      homepage: 'homepage',
      id: 1,
      inProduction: false,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: '/path.jpg',
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1,
      voteCount: 1);

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "first_air_date": "firstAirDate",
            "genre_ids": [1, 2, 3, 4],
            "homepage": "homepage",
            "id": 1,
            "in_production": false,
            "last_air_date": "lastAirDate",
            "name": "name",
            "number_of_episodes": 1,
            "number_of_seasons": 1,
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1,
            "status": "status",
            "tagline": "tagline",
            "type": "type",
            "poster_path": "/path.jpg",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
