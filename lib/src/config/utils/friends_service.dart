import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_friend/src/config/helpers/save_token.dart';
import 'package:my_friend/src/config/utils/constants.dart';
import 'package:my_friend/src/features/chat/data/model/login_model.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';

class FriendsService {
  Future<List<User>> getFriends() async {
    final _dio = Dio();

    // List<User> friends = [];

    final response = await _dio.get(
      '${Environment.apiUrl}/friends',
      options: Options(
        headers: {'x-token': await getToken()},
      ),
    );

    final friendResponse = FriendsResponse.fromMap(response.data);

    return friendResponse.users;
  }
}

class FriendsResponse {
  FriendsResponse({
    required this.status,
    required this.users,
  });

  final String status;
  final List<User> users;

  factory FriendsResponse.fromJson(String str) =>
      FriendsResponse.fromMap(json.decode(str));

  factory FriendsResponse.fromMap(Map<String, dynamic> json) => FriendsResponse(
      status: json["status"],
      users: List<User>.from(
        json["users"].map((x) => UserResponse.fromJson((x))),
      ));
}
