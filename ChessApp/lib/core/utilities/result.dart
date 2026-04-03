import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T, E> with _$Result<T, E> {
  const factory Result.success(T value) = Success<T, E>;
  const factory Result.failure(E error) = Failure<T, E>;
}

final class ValueAccessOnFailureException<TError> implements Exception {
  const ValueAccessOnFailureException({required this.failure});
  
  final TError failure;
  
  @override
  String toString() => 'Result.value cannot be accessed when result in failure state!\nFailure: ${failure.toString()}';
}

extension ResultExtensions<T, TError> on Result<T, TError>  {
  
  Result<T2, TError> map<T2>(T2 Function(T) map) =>
    when(
      success: (success) => Result.success(map(success)), 
      failure: (fail) => Result.failure(fail));
      
  Result<T, TNewError> mapError<TNewError>(TNewError Function(TError) map) =>
    when(
      success: (success) => Result.success(success), 
      failure: (fail) => Result.failure(map(fail)));
      
  Result<T2, TError> bind<T2>(Result<T2, TError> Function(T) bind) =>
    when(
      success: (success) => bind(success), 
      failure: (fail) => Result.failure(fail));
  
  /// Returns value if result in success state. Will throw [ValueAccessOnFailureException] otherwise.
  T get value => when(success: (value) => value, failure: (error) => throw ValueAccessOnFailureException(failure: error));

  Future<T2> whenAsync<T2>({
    required Future<T2> Function(T value) success,
    required Future<T2> Function(TError error) failure,
  }) async {
    return when(
      success: (value) => success(value),
      failure: (error) => failure(error),
    );
  }

  Future<Result<T2, TError>> mapAsync<T2>(
    FutureOr<T2> Function(T value) map,
  ) async {
    return when(
      success: (value) async => Result.success(await map(value)),
      failure: (error) async => Result.failure(error),
    );
  }

  Future<Result<T2, TError>> bindAsync<T2>(
    FutureOr<Result<T2, TError>> Function(T value) bind,
  ) async {
    return when(
      success: (value) => bind(value),
      failure: (error) async => Result.failure(error),
    );
  }

  Future<Result<T, TNewError>> mapErrorAsync<TNewError>(
    FutureOr<TNewError> Function(TError error) map,
  ) async {
    return when(
      success: (value) async => Result.success(value),
      failure: (error) async => Result.failure(await map(error)),
    );
  }
}

extension FutureResultExtensions<T, TError> on Future<Result<T, TError>> {
  Future<Result<T2, TError>> mapAsync<T2>(
    FutureOr<T2> Function(T value) fn,
  ) async {
    final result = await this;
    return result.mapAsync(fn);
  }

  Future<Result<T2, TError>> bindAsync<T2>(
    FutureOr<Result<T2, TError>> Function(T value) fn,
  ) async {
    final result = await this;
    return result.bindAsync(fn);
  }

  Future<Result<T, TNewError>> mapErrorAsync<TNewError>(
    FutureOr<TNewError> Function(TError error) fn,
  ) async {
    final result = await this;
    return result.mapErrorAsync(fn);
  }
}
