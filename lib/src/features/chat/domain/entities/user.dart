// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.name,
    required this.email,
    required this.uid,
  });

  final String name;
  final String email;
  final String uid;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "uid": uid,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, uid];
}
