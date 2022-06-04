// ignore_for_file: slash_for_doc_comments

/**
 * File: dunctionalart.dart
 * Author: 27Onion
 * Description: A library that provides lots of functional features for dart.
 */

extension ListExtension<T> on List<T> {
  List<T> filter(bool Function(T value) predicate) {
    List<T> result = [];
    for (var i in this) {
      if (predicate(i)) {
        result.add(i);
      }
    }
    return result;
  }
}
