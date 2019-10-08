import 'package:equatable/equatable.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:meta/meta.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  Loaded({@required this.numberTrivia});

  @override
  List<Object> get props => [numberTrivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
