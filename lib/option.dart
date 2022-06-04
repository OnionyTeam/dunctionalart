// ignore_for_file: slash_for_doc_comments
/**
 * File: option.dart
 * Author: 27Onion
 * Description: Defines a class to abstract a option.
 */

/// A class that wraps an option value (either L or R)
class Option<L, R> {
  L? _leftValue;
  R? _rightValue;
  late int _direction;

  /// Initialize a left value;
  Option.left(L value) {
    _leftValue = value;
    _rightValue = null;
    _direction = -1;
  }

  /// Initialize a right value.
  Option.right(R value) {
    _leftValue = null;
    _rightValue = value;
    _direction = 1;
  }

  /// Construct an option depends on nullables. If one parameter is non-null and another is null, then use the non-null parameter as the left/right value.
  /// If both parameters are non-null then the right value will be used. Otherwise, an exception will be thrown.
  /// For example:
  /// ```dart
  /// // In this case, 'xxx' and 'yyy' are not null.
  /// Option.fromNullable(null, xxx); // Use xxx as the right value.
  /// Option.fromNullable(xxx, null); // Use xxx as the left value.
  /// Option.fromNullable(xxx, yyy); // Use yyy as the right value.
  /// Option.fromNullable(null, null); // An exception is thrown.
  /// ```
  Option.fromNullable(L? valueLeft, R? valueRight) {
    if (valueLeft != null && valueRight == null) {
      _leftValue = valueLeft;
      _rightValue = null;
      _direction = -1;
    } else if (valueLeft == null && valueRight != null) {
      _rightValue = valueRight;
      _leftValue = null;
      _direction = 1;
    } else if (valueLeft != null && valueRight != null) {
      _rightValue = valueRight;
      _leftValue = null;
      _direction = 1;
    } else {
      throw Exception(
          "Option.fromNullable() should at least has a non-null value");
    }
  }

  /// Check the direction.
  int direction() => _direction;

  /// Do different things depending on the direction
  Option leftOrRight({void Function(L)? onLeft, void Function(R)? onRight}) {
    if (_direction == -1) {
      (onLeft ?? (p0) {})(_leftValue as L);
    } else {
      (onRight ?? (p0) {})(_rightValue as R);
    }
    return this;
  }

  /// Unwrap the value.
  dynamic unwrap() {
    dynamic result;
    leftOrRight(
      onLeft: (p0) => result = _leftValue,
      onRight: (p0) => result = _rightValue,
    );
    return result;
  }

  @override
  String toString() =>
      "<Option::${_direction == -1 ? "Left" : "Right"}> ${_direction == -1 ? _leftValue as L : _rightValue as R}";
}
