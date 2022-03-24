import 'package:equatable/equatable.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';

class LoginUseCase extends UseCase<User, Params> {
  final ChatRepository chatRepository;

  LoginUseCase(this.chatRepository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await chatRepository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginResponse login;

  const Params({
    required this.login,
  });

  @override
  List<Object> get props => [login];
}
