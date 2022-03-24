// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'dart:convert';

import 'package:my_friend/src/features/chat/domain/entities/message.dart';

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));

String messagesToJson(Messages data) => json.encode(data.toJson());

class Messages {
  Messages({
    required this.messageResponse,
  });

  List<MessageResponse> messageResponse;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        messageResponse: List<MessageResponse>.from(
            json["messages"].map((x) => MessageResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messageResponse.map((x) => x.toJson())),
      };
}

class MessageResponse extends Message {
  MessageResponse({
    required this.of,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          createdAt: createdAt,
          updatedAt: updatedAt,
          to: to,
          of: of,
          message: message,
        );

  String of;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        of: json["of"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "of": of,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
