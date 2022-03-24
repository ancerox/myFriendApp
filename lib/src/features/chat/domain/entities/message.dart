import 'package:equatable/equatable.dart';

class Message extends Equatable {
  Message({
    required this.of,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String of;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  @override
  // TODO: implement props
  List<Object?> get props => [of, to, message, createdAt, updatedAt];
}
