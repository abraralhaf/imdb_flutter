// Mocks generated by Mockito 5.2.0 from annotations
// in tv_series_imdb/test/presentation/pages/popular_tv_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series_imdb/presentation/bloc/popular_tv/popular_tv_bloc.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakePopularTvState_0 extends _i1.Fake implements _i2.PopularTvState {}

/// A class which mocks [PopularTvBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularTvBloc extends _i1.Mock implements _i2.PopularTvBloc {
  MockPopularTvBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PopularTvState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakePopularTvState_0()) as _i2.PopularTvState);
  @override
  _i3.Stream<_i2.PopularTvState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.PopularTvState>.empty())
          as _i3.Stream<_i2.PopularTvState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i2.PopularTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i2.PopularTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.PopularTvState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i2.PopularTvEvent>(
          _i4.EventHandler<E, _i2.PopularTvState>? handler,
          {_i4.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i4.Transition<_i2.PopularTvEvent, _i2.PopularTvState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  void onChange(_i4.Change<_i2.PopularTvState>? change) =>
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
