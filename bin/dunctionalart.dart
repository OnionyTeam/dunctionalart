import 'package:dunctionalart/failable.dart';
import 'package:dunctionalart/option.dart';
import 'package:dunctionalart/result.dart';
import 'package:dunctionalart/dunctionalart.dart';

void main(List<String> arguments) {
  Result<int> result = Result.failed();
  Result<int> result2 = Result.success(3);
  Result<int> result3 = Result.success(114514 - 3);
  Option<int, String> option1 = Option.left(1);
  Option<int, String> option2 = Option.right("hi");
  print("$result \n$result2 \n$result 3\n");
  print(
      "Merging results(result 1 and result 2): ${result.merge(result2, (p0, p1) => p0 + p1)}");
  print(
      "Merging results(result 2 and result 3): ${result2.merge(result3, (p0, p1) => p0 + p1)}");
  print("$option1, $option2.");
  print("${[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].filter((numb) => numb < 5)}");
  print(
      "Unwarp two options, option1: ${option1.unwrap()}, and option2: ${option2.unwrap()}");
  print("Result from nullable ${Result.fromNullableValue(null)}");
  print("Result from nullable ${Result.fromNullableValue(3)}");
  print("Result from nullable ${Result.fromNullableValue("Hello, World!")}");
  print("Result from nullable ${Result.fromNullableValue(114514.1234)}");
  print("Result from nullable ${Result.fromNullableValue(Result.failed())}");
  print(
      "Here, something failed ${Failable.failure("just want to be failed!")}.");
  print(
      "And something succeeded ${Failable.success("Oh success! My success!")}!");
}
