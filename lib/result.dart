// ignore_for_file: slash_for_doc_comments
/**
 * File: result.dart
 * Author: 27Onion
 * Description: Defines a class to abstract a result.
 */

/// A class that wraps a optional value.
class Result<T> {
  T? _value;
  bool _solved = false;

  /// Contruct a result object from a nullable value.<br/>
  /// If the value is null, then the result will be failed.<br/>
  /// Otherwise, the result will be solved.
  Result.fromNullableValue(T? value) {
    value == null ? _setFailure() : _setSuccess(value as T);
  }

  void _setFailure() {
    _solved = false;
    _value = null;
  }

  void _setSuccess(T value) {
    _value = value;
    _solved = true;
  }

  /// Contruct a failed result.
  Result.failed() {
    _setFailure();
  }

  /// Construct a successful result.
  Result.success(T value) {
    _setSuccess(value);
  }

  /// Force unwrap the value.
  T unwrap() {
    if (_solved) {
      return _value!;
    } else {
      throw Exception("cannot unwrap a failed result");
    }
  }

  /// Process failed values.
  Result<T> except(void Function() callback) {
    if (!_solved) {
      callback();
    }
    return this;
  }

  /// To string.
  @override
  String toString() {
    if (_solved) {
      return "<Solved> $_value";
    } else {
      return "<Failed>";
    }
  }

  /// Merge two results with same type.
  Result<T> merge(Result<T> result2, T Function(T, T) mergeCallback) {
    return mergeDiff(result2, mergeCallback);
  }

  /// Merge two different results.
  Result<V> mergeDiff<U, V>(Result<U> result2, V Function(T, U) mergeCallback) {
    if (!(_solved && result2._solved)) {
      return Result.failed();
    } else {
      return Result.success(mergeCallback(_value as T, result2._value as U));
    }
  }

  /// Returns if the result is solved or failed.
  bool isSolved() {
    return _solved;
  }
}
