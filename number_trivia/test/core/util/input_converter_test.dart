import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';

void main() {
  InputConverter converter = new InputConverter();

  test('parses a string to an integer', () {
    final str = '123';

    final result = converter.stringToUnsignedInteger(str);

    expect(result, equals(Right(123)));
  });

  test('fails when the string is not an integer', () {
    final str = '1.0';

    final result = converter.stringToUnsignedInteger(str);

    expect(result, equals(Left(InvalidInputFailure())));
  });
  
  test('fails when the string is a negative integer', () {
    final str = '-10';

    final result = converter.stringToUnsignedInteger(str);

    expect(result, equals(Left(InvalidInputFailure())));
  });
}
