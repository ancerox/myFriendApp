import 'package:dartz/dartz.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';

abstract class ChatRepository {
  Future<Either<Failure, User>> login(LoginResponse login);
  Future<Either<Failure, User>> tokenVerification();
  Future<Either<Failure, List<Message>>> getMessages(String userId);
  Future<Either<Failure, User>> getNewUser(creds);
  Future<Either<Failure, bool>> deleteFriend(String uid);
}
