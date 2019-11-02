import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The number must be greater than or equal to 0";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    GetConcreteNumberTrivia concrete,
    GetRandomNumberTrivia random,
    this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      yield* _getTriviaForConcreteNumber(event);
    } else if (event is GetTriviaForRandomNumber) {
      yield* _getTriviaForRandomNumber();
    }
  }

  Stream<NumberTriviaState> _getTriviaForRandomNumber() async* {
    yield Loading();
    final failureOrTrivia = await getRandomNumberTrivia(
      NoParams(),
    );
    yield failureOrTrivia.fold(
      (failure) => Error(message: _error(failure)),
      (trivia) => Loaded(numberTrivia: trivia),
    );
  }

  Stream<NumberTriviaState> _getTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event) async* {
    final inputEither = inputConverter.stringToUnsignedInteger(
      event.numberString,
    );

    yield* inputEither.fold(
      (failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      },
      (number) async* {
        yield Loading();
        final failureOrTrivia = await getConcreteNumberTrivia(
          Params(number: number),
        );
        yield failureOrTrivia.fold(
          (failure) => Error(message: _error(failure)),
          (trivia) => Loaded(numberTrivia: trivia),
        );
      },
    );
  }

  String _error(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
