import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDatasource datasource;
  MockSharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    datasource = NumberTriviaLocalDatasourceImpl(
      sharedPreferences: sharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final numberTrivia = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia_cached.json')),
    );
    test(
        'should return number trivia from shared preferences where there is one cached',
        () async {
      when(sharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await datasource.getLastNumberTrivia();

      verify(sharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(numberTrivia));
    });

    test('should throw CacheException when there is no value cached', () async {
      when(sharedPreferences.getString(any)).thenReturn(null);

      final call = datasource.getLastNumberTrivia;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    test('should save the number trivia to sharedPreferences', () async {
      final numberTrivia = NumberTriviaModel(number: 1, text: 'test trivia');

      datasource.cacheNumberTrivia(numberTrivia);

      final expectedJson = json.encode(numberTrivia.toJson());
      verify(sharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJson));
    });
  });
}
