// Mocks generated by Mockito 5.2.0 from annotations
// in movie_package/test/presentation/pages/movies_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_package/presentation/bloc/movie_detail/movie_detail_bloc.dart'
    as _i2;
import 'package:movie_package/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart'
    as _i3;
import 'package:movie_package/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieDetailState_0 extends _i1.Fake implements _i2.MovieDetailState {
}

class _FakeMovieRecommendationState_1 extends _i1.Fake
    implements _i3.MovieRecommendationState {}

class _FakeMovieWatchlistState_2 extends _i1.Fake
    implements _i4.MovieWatchlistState {}

/// A class which mocks [MovieDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailBloc extends _i1.Mock implements _i2.MovieDetailBloc {
  MockMovieDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieDetailState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeMovieDetailState_0()) as _i2.MovieDetailState);
  @override
  _i5.Stream<_i2.MovieDetailState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.MovieDetailState>.empty())
          as _i5.Stream<_i2.MovieDetailState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i2.MovieDetailEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i2.MovieDetailEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.MovieDetailState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i2.MovieDetailEvent>(
          _i6.EventHandler<E, _i2.MovieDetailState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i2.MovieDetailEvent, _i2.MovieDetailState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void onChange(_i6.Change<_i2.MovieDetailState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

/// A class which mocks [MovieRecommendationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRecommendationBloc extends _i1.Mock
    implements _i3.MovieRecommendationBloc {
  MockMovieRecommendationBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRecommendationState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeMovieRecommendationState_1())
          as _i3.MovieRecommendationState);
  @override
  _i5.Stream<_i3.MovieRecommendationState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.MovieRecommendationState>.empty())
          as _i5.Stream<_i3.MovieRecommendationState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i5.FutureOr<void> fetchMovieRecommendation(
          _i3.FetchMovieRecommendation? event,
          _i6.Emitter<_i3.MovieRecommendationState>? emit) =>
      (super.noSuchMethod(
              Invocation.method(#fetchMovieRecommendation, [event, emit]))
          as _i5.FutureOr<void>);
  @override
  void add(_i3.MovieRecommendationEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.MovieRecommendationEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.MovieRecommendationState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.MovieRecommendationEvent>(
          _i6.EventHandler<E, _i3.MovieRecommendationState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i3.MovieRecommendationEvent,
                  _i3.MovieRecommendationState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void onChange(_i6.Change<_i3.MovieRecommendationState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

/// A class which mocks [MovieWatchlistBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieWatchlistBloc extends _i1.Mock
    implements _i4.MovieWatchlistBloc {
  MockMovieWatchlistBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieWatchlistState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeMovieWatchlistState_2()) as _i4.MovieWatchlistState);
  @override
  _i5.Stream<_i4.MovieWatchlistState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.MovieWatchlistState>.empty())
          as _i5.Stream<_i4.MovieWatchlistState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i4.MovieWatchlistEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i4.MovieWatchlistEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i4.MovieWatchlistState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i4.MovieWatchlistEvent>(
          _i6.EventHandler<E, _i4.MovieWatchlistState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i4.MovieWatchlistEvent, _i4.MovieWatchlistState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void onChange(_i6.Change<_i4.MovieWatchlistState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
