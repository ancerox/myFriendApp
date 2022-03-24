import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_friend/src/features/chat/data/model/login_model.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLoginModel =
      UserResponse(email: 'test1@outlook.es', password: '123123');

  test('Should be a subclass of LoginResponse', () async {
    expect(tLoginModel, isA<LoginResponse>());
  });
  group('FromJson', () {
    test('Should return a valid instance of LoginModel', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('login_response.json'));

      final result = UserResponse.fromJson(jsonMap);

      expect(result, tLoginModel);
    });

    test('Should JSON map with the proper data', () {
      final result = tLoginModel.toJson();

      final expectedMap = {"email": 'test1@outlook.es', "password": '123123'};

      expect(result, expectedMap);
    });
  });
}
