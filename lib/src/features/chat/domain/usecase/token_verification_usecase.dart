import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';

class TokenVerification extends UseCase<User, NoParams> {
  final ChatRepository chatRepository;

  TokenVerification(this.chatRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return chatRepository.tokenVerification();
  }
}
