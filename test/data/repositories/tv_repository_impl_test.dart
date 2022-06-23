import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_imdb/common/exception.dart';
import 'package:tv_series_imdb/data/models/genre_model.dart';
import 'package:tv_series_imdb/data/models/seasons_model.dart';
import 'package:tv_series_imdb/data/models/tv_detail_model.dart';
import 'package:tv_series_imdb/data/models/tv_model.dart';
import 'package:tv_series_imdb/data/repositories/tv_repository_impl.dart';

import 'package:tv_series_imdb/domain/entities/tv.dart';
import 'package:tv_series_imdb/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource);
  });

  final tTvModel = TvModel(
    backdropPath: '/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
    firstAirDate: '2016-07-15',
    genreIds: [10765, 18, 9648],
    homepage: 'homepage',
    id: 66732,
    inProduction: false,
    lastAirDate: 'lastAirDate',
    name: 'Stranger Things',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Stranger Things',
    overview:
        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
    popularity: 3118.667,
    posterPath: '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 8.6,
    voteCount: 10865,
    adult: false,
  );

  final tTv = Tv(
    backdropPath: '/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
    firstAirDate: '2016-07-15',
    genreIds: [10765, 18, 9648],
    homepage: 'homepage',
    id: 66732,
    inProduction: false,
    lastAirDate: 'lastAirDate',
    name: 'Stranger Things',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Stranger Things',
    overview:
        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
    popularity: 3118.667,
    posterPath: '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 8.6,
    voteCount: 10865,
    adult: false,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      // expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockRemoteDataSource.getPopularTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      // expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv', () {
    // test(
    //     'should return remote data when the call to remote data source is successful',
    //     () async {
    //   // arrange
    //   when(mockRemoteDataSource.getPopularTv())
    //       .thenAnswer((_) async => tTvModelList);
    //   // act
    //   final result = await repository.getTopRatedTv();
    //   // assert
    //   verify(mockRemoteDataSource.getTopRatedTv());
    //   /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
    //   final resultList = result.getOrElse(() => []);
    //   // expect(resultList, tTvList);
    // });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Detail Tv', () {
    final tId = 1;
    final tTvResponse = TvDetailResponse(
        adult: false,
        backdropPath: 'backdropPath',
        firstAirDate: 'firstAirDate',
        genres: [GenreModel(id: 1, name: 'Action')],
        homepage: 'homepage',
        id: 1,
        inProduction: false,
        seasons: [
          SeasonModel(
              id: 1,
              name: 'name',
              air_date: 'air_date',
              poster_path: '/path.jpg',
              season_number: 1,
              episode_count: 1,
              overview: 'overview')
        ],
        lastAirDate: 'lastAirDate',
        name: 'name',
        numberOfEpisodes: 1,
        numberOfSeasons: 1,
        originalLanguage: 'en',
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: '/path.jpg',
        status: 'status',
        tagline: 'tagline',
        type: 'type',
        voteAverage: 1,
        voteCount: 1);

    // test(
    //     'should return Movie data when the call to remote data source is successful',
    //     () async {
    //   // arrange
    //   when(mockRemoteDataSource.getTvDetail(tId))
    //       .thenAnswer((_) async => tTvResponse);
    //   //act
    //   final result = await repository.getTvDetail(tId);
    //   //assert
    //   verify(mockRemoteDataSource.getTvDetail(tId));
    //   expect(result, equals(Right(testTvDetail)));
    // });
    test(
        'should return Server Failure when the call to the remote data source is unsuccessfull',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is no connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach tv', () {
    final tQuery = 'stranger';
    // test('should return movie list when call to data source is successful',
    //     () async {
    //   // arrange
    //   when(mockRemoteDataSource.searchTv(tQuery))
    //       .thenAnswer((_) async => tTvModelList);
    //   // act
    //   final result = await repository.searchTv(tQuery);
    //   // assert
    //   /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
    //   final resultList = result.getOrElse(() => []);
    //   expect(resultList, tTvList);
    // });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
