import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  GetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  GetRandomNumberTrivia mockGetRandomNumberTrivia;
  InputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () async {
    expect(bloc.initialState, Empty());
  });

  group('GetTriviaForConcreteNumber', () {
    final number = "1";
    final parsedNumber = 1;
    final numberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test('validates the input using InputConverter', () async {
      when(mockInputConverter.stringToUnsignedInteger(number))
          .thenReturn(Right(parsedNumber));

      bloc.dispatch(GetTriviaForConcreteNumber(number));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(number));
    });

    test('should emit State when the input is invalid', () {
      final expectedStates = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];

      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      expectLater(bloc.state, emitsInOrder(expectedStates));

      bloc.dispatch(GetTriviaForConcreteNumber(number));
    });
  });
}
