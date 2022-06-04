import 'package:dunctionalart/result.dart';
import 'package:test/test.dart';

void main() {
  test('result', () {
    Result<int> result = Result.failed();
    print(result);
    assert(result.toString() == "<Failed>");
  });
}
