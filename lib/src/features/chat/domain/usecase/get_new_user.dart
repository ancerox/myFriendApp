import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';

class GetNewUser extends UseCase<User, NewUserParams> {
  final ChatRepository chatRepository;

  GetNewUser(this.chatRepository);

  @override
  Future<Either<Failure, User>> call(NewUserParams newUserParams) async {
    return await chatRepository.getNewUser(newUserParams);
  }
}

class NewUserParams {
  final String email;
  final String password;
  final String name;

  NewUserParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
