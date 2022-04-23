import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';

class DeleteMessage extends UseCase<bool, String> {
  ChatRepository chatRepository;
  DeleteMessage(this.chatRepository);

  @override
  Future<Either<Failure, bool>> call(messageId) async {
    return await chatRepository.deleteMessage(messageId);
  }
}
