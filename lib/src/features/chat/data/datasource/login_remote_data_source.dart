import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_friend/src/config/helpers/save_token.dart';
import 'package:my_friend/src/config/utils/constants.dart';
import 'package:my_friend/src/features/chat/data/model/login_model.dart';
import 'package:my_friend/src/features/chat/data/model/message_response.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/domain/usecase/get_new_user.dart';

abstract class AuthRemoteDataSource {
  /// Calls the http:// endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserResponse> login(LoginResponse loginResponse);
  Future<UserResponse> tokenVerification();
  Future<List<MessageResponse>> getMessages(String userid);
  Future<UserResponse> getNewUser(NewUserParams newUserParams);
  Future<bool> deleteFriend(String uid);
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

    final resp = await dioClient.post(
        'https://my-friend-ancerox.herokuapp.com/api/login',

        // options: Options(
        //   contentType: 'application/json',
        // ),
        data: creds);

    final token = await resp.data['token'];
    print(token);
    saveToken(token);

    final user = UserResponse.fromJson(resp.data['userDb']);

    return user;
  }

  @override
  Future<UserResponse> tokenVerification() async {
    final token = await storage.read(key: 'token');

    final resp = await dioClient.get(
        'https://my-friend-ancerox.herokuapp.com/api/login/renew',
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

    final resp = await dioClient.get(
        'https://my-friend-ancerox.herokuapp.com/api/messages/$userId',
        options: Options(
          headers: {"x-token": token},
          contentType: 'application/json',
        ));

    final messageRep = Messages.fromJson(resp.data);

    return messageRep.messageResponse;
  }

  @override
  Future<UserResponse> getNewUser(NewUserParams newUserParams) async {
    final resp = await dioClient
        .post('https://my-friend-ancerox.herokuapp.com/api/login/new',
            options: Options(
              contentType: 'application/json',
            ),
            data: {
          "email": newUserParams.email,
          "name": newUserParams.name,
          "password": newUserParams.password,
        });

    final token = await resp.data['token'];

    saveToken(token);

    final newUser = UserResponse.fromJson(resp.data['user']);

    return newUser;
  }

  @override
  Future<bool> deleteFriend(String uid) async {
    final token = await storage.read(key: 'token');

    final resp = await dioClient.get(
      'https://my-friend-ancerox.herokuapp.com/api/deletefriend$uid',
      options: Options(headers: {"x-token": token}),
    );

    if (resp.data['ok']) {
      return true;
    } else {
      return false;
    }
  }
}
