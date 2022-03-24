import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_friend/src/config/helpers/save_token.dart';
import 'package:my_friend/src/config/utils/constants.dart';
import 'package:my_friend/src/features/chat/data/model/login_model.dart';
import 'package:my_friend/src/features/chat/data/model/message_response.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  /// Calls the http:// endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserResponse> login(LoginResponse loginResponse);
  Future<UserResponse> tokenVerification();
  Future<List<MessageResponse>> getMessages(String userid);
}

class AuthRemoteDataSourceIMPL extends AuthRemoteDataSource {
  final Dio dioClient;
  AuthRemoteDataSourceIMPL({required this.dioClient});

  @override
  Future<UserResponse> login(LoginResponse loginResponse) async {
    // print(dio.options);
    final creds = {
      "email": loginResponse.email,
      "password": loginResponse.password,
    };

    final resp = await dioClient.post('${Environment.apiUrl}/login',

        // options: Options(
        //   contentType: 'application/json',
        // ),
        data: creds);

    final token = await resp.data['token'];

    saveToken(token);

    final user = UserResponse.fromJson(resp.data['userDb']);

    return user;
  }

  @override
  Future<UserResponse> tokenVerification() async {
    final token = await storage.read(key: 'token');

    final resp = await dioClient.get('${Environment.apiUrl}/login/renew',
        options: Options(
          headers: {"x-token": token},
          contentType: 'application/json',
        ));

    final user = UserResponse.fromJson(resp.data['user']);

    return user;
  }

  @override
  Future<List<MessageResponse>> getMessages(String userId) async {
    final token = await storage.read(key: 'token');

    final resp = await dioClient.get('${Environment.apiUrl}/messages/$userId',
        options: Options(
          headers: {"x-token": token},
          contentType: 'application/json',
        ));

    final messageRep = Messages.fromJson(resp.data);

    return messageRep.messageResponse;
  }
}
