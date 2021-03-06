// Mocks generated by Mockito 5.2.0 from annotations
// in tv_series_imdb/test/presentation/pages/detail_tv_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series_imdb/presentation/bloc/detail_tv/detail_tv_bloc.dart'
    as _i2;
import 'package:tv_series_imdb/presentation/bloc/recommendation_tv/bloc/recommendation_tv_bloc.dart'
    as _i3;
import 'package:tv_series_imdb/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart'
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

class _FakeDetailTvState_0 extends _i1.Fake implements _i2.DetailTvState {}

class _FakeRecommendationTvState_1 extends _i1.Fake
    implements _i3.RecommendationTvState {}

class _FakeWatchlistTvState_2 extends _i1.Fake implements _i4.WatchlistTvState {
}

/// A class which mocks [DetailTvBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockDetailTvBloc extends _i1.Mock implements _i2.DetailTvBloc {
  MockDetailTvBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DetailTvState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeDetailTvState_0()) as _i2.DetailTvState);
  @override
  _i5.Stream<_i2.DetailTvState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.DetailTvState>.empty())
          as _i5.Stream<_i2.DetailTvState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i2.DetailTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i2.DetailTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.DetailTvState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i2.DetailTvEvent>(
          _i6.EventHandler<E, _i2.DetailTvState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i2.DetailTvEvent, _i2.DetailTvState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void onChange(_i6.Change<_i2.DetailTvState>? change) =>
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

/// A class which mocks [RecommendationTvBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockRecommendationTvBloc extends _i1.Mock
    implements _i3.RecommendationTvBloc {
  MockRecommendationTvBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.RecommendationTvState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeRecommendationTvState_1())
          as _i3.RecommendationTvState);
  @override
  _i5.Stream<_i3.RecommendationTvState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.RecommendationTvState>.empty())
          as _i5.Stream<_i3.RecommendationTvState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.RecommendationTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.RecommendationTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.RecommendationTvState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.RecommendationTvEvent>(
          _i6.EventHandler<E, _i3.RecommendationTvState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i3.RecommendationTvEvent, _i3.RecommendationTvState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void onChange(_i6.Change<_i3.RecommendationTvState>? change) =>
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

/// A class which mocks [WatchlistTvBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistTvBloc extends _i1.Mock implements _i4.WatchlistTvBloc {
  MockWatchlistTvBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WatchlistTvState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeWatchlistTvState_2()) as _i4.WatchlistTvState);
  @override
  _i5.Stream<_i4.WatchlistTvState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.WatchlistTvState>.empty())
          as _i5.Stream<_i4.WatchlistTvState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i4.WatchlistTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i4.WatchlistTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i4.WatchlistTvState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i4.WatchlistTvEvent>(
          _i6.EventHandler<E, _i4.WatchlistTvState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i4.WatchlistTvEvent, _i4.WatchlistTvState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void onChange(_i6.Change<_i4.WatchlistTvState>? change) =>
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
