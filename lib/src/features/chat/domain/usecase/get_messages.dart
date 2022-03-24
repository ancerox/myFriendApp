import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';
import 'package:my_friend/src/features/chat/domain/usecase/login_usecase.dart';

class GetMessagues extends UseCase<List<Message>, String> {
  ChatRepository chatRepository;
  GetMessagues(this.chatRepository);

  @override
  Future<Either<Failure, List<Message>>> call(userid) async {
    return chatRepository.getMessages(userid);
  }
}
