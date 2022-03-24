import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_friend/src/config/error/exception.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:my_friend/src/config/network/network_info.dart';
import 'package:my_friend/src/features/chat/data/datasource/login_remote_data_source.dart';
import 'package:my_friend/src/features/chat/data/model/login_model.dart';
import 'package:my_friend/src/features/chat/data/repository/login_repository_impl.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late LoginRepositoryIMPL repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const loginResponde =
      LoginResponse(email: 'winstonf@test.com', password: '123123');

  const loginModel = LoginModel(email: "winstonf@test.com", password: "123123");
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryIMPL(
      loginRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );

    registerFallbackValue(loginModel);
  });

  group('LoginUseCase', () {
    test('should check if the device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.login(loginResponde))
          .thenAnswer((_) async => true);

      await repository.login(loginResponde);

      verify(() => mockNetworkInfo.isConnected);
      const Skip();
    });

    test('should return remote data when is conection available', () async {
      when(() => mockRemoteDataSource.login(loginResponde))
          .thenAnswer((_) async => true);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.login(loginResponde);

      verify(() => mockRemoteDataSource.login(loginResponde));
      expect(result, const Right(true));
    });

    test('should trown an exeption when data is unsuccessful', () async {
      when(() => mockRemoteDataSource.login(loginResponde))
          .thenThrow(ServerException());
      final result = await repository.login(loginResponde);

      verify(() => mockRemoteDataSource.login(loginResponde));
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
