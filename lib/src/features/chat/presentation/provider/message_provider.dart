import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/domain/usecase/get_messages.dart';

import '../../domain/usecase/delete_message.dart';
import '../../domain/usecase/report_msg.dart';
import '../components/componets.dart';

class MessageProvider extends ChangeNotifier {
  GetMessagues getMessagesUseCase;
  DeleteMessage deleteMessageUsecase;
  ReportMsg reportMsgUseCase;

  List<BubbleMessage> _userMessages = [];

  List<BubbleMessage> get userMessages => _userMessages;

  set userMessages(list) {
    _userMessages = list;
    notifyListeners();
  }

  MessageProvider(
      {required this.getMessagesUseCase,
      required this.deleteMessageUsecase,
      required this.reportMsgUseCase});

  getMessages(String userId) async {
    Either<Failure, List<Message>> data = await getMessagesUseCase(userId);

    return data.fold(
        (l) => {print('Error al recivir mensaje de base de datos')}, (r) => r);
  }

  deleteMessage(String messageId) async {
    Either<Failure, bool> data = await deleteMessageUsecase(messageId);

    return data.fold((l) => false, (r) => true);
  }

  reportMsg(String messageId) async {
    Either<Failure, bool> data = await reportMsgUseCase(messageId);

    return data.fold((l) => false, (r) => true);
  }
}
