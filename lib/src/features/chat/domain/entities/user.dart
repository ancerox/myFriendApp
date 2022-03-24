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
    required this.online,
  });

  final String name;
  final String email;
  final String uid;
  final bool online;

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, uid, online];
}
