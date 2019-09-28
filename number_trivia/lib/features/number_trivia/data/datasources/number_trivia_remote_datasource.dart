import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDatasource {
  /// calls the http://numbersapi.com/{number} endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  
  /// calls the http://numbersapi.com/random endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<NumberTrivia> getRandomNumberTrivia();
}