import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDatasource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocalDatasource extends Mock implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDatasource mockRemoteDatasource;
  MockLocalDatasource mockLocalDatasource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockRemoteDatasource();
    mockLocalDatasource = MockLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();

    repository = NumberTriviaRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    final testNumber = 1;
    final testNumberTriviaModel =
        NumberTriviaModel(number: testNumber, text: 'test trivia');
    final testNumberTrivia = testNumberTriviaModel;

    test('should check if the device is online', () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getConcreteNumberTrivia(testNumber);

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote datasource is successful',
          () async {
        when(mockRemoteDatasource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => testNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(testNumber);

        expect(result, equals(Right(testNumberTrivia)));
        verify(mockRemoteDatasource.getConcreteNumberTrivia(testNumber));
      });

      test('should cache the data returned by the remote datasource', () async {
        when(mockRemoteDatasource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => testNumberTriviaModel);

        await repository.getConcreteNumberTrivia(testNumber);

        verify(mockRemoteDatasource.getConcreteNumberTrivia(testNumber));
        verify(mockLocalDatasource.cacheNumberTrivia(testNumberTriviaModel));
      });

      test(
          'should return server failure when the call to remote datasource is unsuccessful',
          () async {
        when(mockRemoteDatasource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final result = await repository.getConcreteNumberTrivia(testNumber);

        expect(result, equals(Left(ServerFailure())));
        verify(mockRemoteDatasource.getConcreteNumberTrivia(testNumber));
        verifyZeroInteractions(mockLocalDatasource);
      });
    });

    runTestsOffline(() {
      test('should last cached data when cached data is present', () async {
        when(mockLocalDatasource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(testNumber);

        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getLastNumberTrivia());
        expect(result, equals(Right(testNumberTrivia)));
      });

      test('should return CacheFailure when there is no cached data', () async {
        when(mockLocalDatasource.getLastNumberTrivia())
            .thenThrow(CacheException());

        final result = await repository.getConcreteNumberTrivia(testNumber);

        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final testNumber = 1;
    final testNumberTriviaModel =
        NumberTriviaModel(number: testNumber, text: 'test trivia');
    final testNumberTrivia = testNumberTriviaModel;

    test('should check if the device is online', () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getRandomNumberTrivia();

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote datasource is successful',
          () async {
        when(mockRemoteDatasource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

        final result = await repository.getRandomNumberTrivia();

        expect(result, equals(Right(testNumberTrivia)));
        verify(mockRemoteDatasource.getRandomNumberTrivia());
      });

      test('should cache the data returned by the remote datasource', () async {
        when(mockRemoteDatasource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

        await repository.getRandomNumberTrivia();

        verify(mockRemoteDatasource.getRandomNumberTrivia());
        verify(mockLocalDatasource.cacheNumberTrivia(testNumberTriviaModel));
      });

      test(
          'should return server failure when the call to remote datasource is unsuccessful',
          () async {
        when(mockRemoteDatasource.getRandomNumberTrivia())
            .thenThrow(ServerException());

        final result = await repository.getRandomNumberTrivia();

        expect(result, equals(Left(ServerFailure())));
        verify(mockRemoteDatasource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDatasource);
      });
    });

    runTestsOffline(() {
      test('should last cached data when cached data is present', () async {
        when(mockLocalDatasource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

        final result = await repository.getRandomNumberTrivia();

        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getLastNumberTrivia());
        expect(result, equals(Right(testNumberTrivia)));
      });

      test('should return CacheFailure when there is no cached data', () async {
        when(mockLocalDatasource.getLastNumberTrivia())
            .thenThrow(CacheException());

        final result = await repository.getRandomNumberTrivia();

        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
