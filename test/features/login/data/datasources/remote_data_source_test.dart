import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_friend/src/features/chat/data/datasource/login_remote_data_source.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late AuthRemoteDataSourceIMPL loginRemoteDataSourceIMPL;
  late MockDioClient mockDioClient;
  late DioAdapter dioAdapter;
  late Dio dio;

  const loginResponde =
      LoginResponse(email: 'winstonf@test.com', password: '123123');

  const baseUrl = 'localhost:3000/api';

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    mockDioClient = MockDioClient();
    dioAdapter = DioAdapter(dio: dio);

    loginRemoteDataSourceIMPL =
        AuthRemoteDataSourceIMPL(dioClient: mockDioClient);
    registerFallbackValue(loginResponde);
  });

  void setUpMockDioSuccess200() {
    when(
      () => mockDioClient.post(any(), data: {
        "email": loginResponde.email,
        "password": loginResponde.password,
      }),
    ).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: 'localhost:3000/api/login'),
        statusCode: 200));
  }

  test('Shoudl Peform a valid get request', () async {
    setUpMockDioSuccess200();

    await loginRemoteDataSourceIMPL.login(loginResponde);

    verify(() => mockDioClient.post('localhost:3000/api/login', data: {
          "email": loginResponde.email,
          "password": loginResponde.password,
        }));
  });
  test('Should return true when data is valid', () async {
    setUpMockDioSuccess200();

    final result = await loginRemoteDataSourceIMPL.login(loginResponde);

    expect(result, true);
  });
}
