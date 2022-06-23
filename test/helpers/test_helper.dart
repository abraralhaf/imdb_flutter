import 'package:tv_series_imdb/data/datasources/db/db_helper.dart';
import 'package:tv_series_imdb/data/datasources/local/tv_local_data_source.dart';
import 'package:tv_series_imdb/data/datasources/remote/tv_remote_data_source.dart';
import 'package:tv_series_imdb/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
