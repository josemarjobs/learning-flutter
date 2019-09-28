import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final numberTrivia = NumberTriviaModel(text: 'Test Text', number: 2);
  test('should be a subclass of NumberTrivia entity', () {
    expect(numberTrivia, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('shout return a valid model when the JSON number is an integer', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      
      final result = NumberTriviaModel.fromJson(jsonMap);
      
      expect(result, numberTrivia);
    });

    test('shout return a valid model when the JSON number is treated as a double', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      
      final result = NumberTriviaModel.fromJson(jsonMap);
      
      expect(result, numberTrivia);
    });
  });

  group('toJson', () {
    test('returns a json map with the correct data', () async {
      final result = numberTrivia.toJson();
      
      final expectedMap = {"text": "Test Text", "number": 2};
      expect(result, expectedMap);
    });
  });
}