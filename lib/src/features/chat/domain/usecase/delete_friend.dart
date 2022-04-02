import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';

class DeleteFriend extends UseCase<bool, String> {
  ChatRepository chatRepository;

  DeleteFriend(this.chatRepository);

  @override
  Future<Either<Failure, bool>> call(String uid) async {
    return await chatRepository.deleteFriend(uid);
  }
}
