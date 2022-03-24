import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/domain/usecase/get_messages.dart';

class MessageProvider extends ChangeNotifier {
  GetMessagues getMessagesUseCase;

  MessageProvider(this.getMessagesUseCase);

  getMessages(String userId) async {
    Either<Failure, List<Message>> data = await getMessagesUseCase(userId);

    return data.fold(
        (l) => {print('Error al recivir mensaje de base de datos')}, (r) => r);
  }
}
