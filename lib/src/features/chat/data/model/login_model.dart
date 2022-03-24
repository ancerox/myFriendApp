import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';

class UserResponse extends User {
  final String email;
  final String name;
  final String uid;
  final bool online;

  const UserResponse(
      {required this.email,
      required this.name,
      required this.uid,
      required this.online})
      : super(email: email, name: name, uid: uid, online: online);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        email: json['email'],
        name: json['name'],
        uid: json['uid'],
        online: json['online']);
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "name": name, "uid": uid, "online": online};
  }
}
