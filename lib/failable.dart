// ignore_for_file: slash_for_doc_comments
/**
 * File: failable.dart
 * Author: 27Onion
 * Description: Defines a class to abstract a result, but will provide a message when failure.
 */

import './option.dart';
import './result.dart';

/// A result but provide a message when failure.
class Failable<ValueType, ErrorDescriptionType>
    extends Option<ErrorDescriptionType, ValueType> {
  Failable.fromNullable(ValueType? value, ErrorDescriptionType? description)
      : super.fromNullable(description, value);
  Failable.failure(ErrorDescriptionType description) : super.left(description);
  Failable.success(ValueType value) : super.right(value);

  /// Merge two `Failable` values.
  Failable<ValueType, ErrorDescriptionType> merge(
      Failable<ValueType, ErrorDescriptionType> another,
      ValueType Function(ValueType, ValueType) mergeCallback) {
    if (failed() || another.failed()) {
      return Failable.fromNullable(
          null, failed() ? unwrap() : another.unwrap());
    }
    return Failable.fromNullable(
        mergeCallback(unwrap(), another.unwrap()), null);
  }

  /// Give up the error description so that the `Failable<V, E>` will be turned into a `Result<V>`.
  Result<ValueType> giveUpDescription() =>
      failed() ? Result.failed() : Result.success(unwrap());

  bool failed() => direction() == -1;
}
