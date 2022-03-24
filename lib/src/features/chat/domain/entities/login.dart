import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String email;
  final String password;

  const LoginResponse({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
