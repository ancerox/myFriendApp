import 'package:my_friend/src/features/chat/data/datasource/login_remote_data_source.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';

class AuthRepositoryIMPL extends ChatRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  // final NetworkInfo networkInfo;

  AuthRepositoryIMPL({
    required this.authRemoteDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(login) async {
    try {
      User loginResponde = await authRemoteDataSource.login(login);
      return Right(loginResponde);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> tokenVerification() async {
    try {
      User tokenVerificationResponse =
          await authRemoteDataSource.tokenVerification();
      return Right(tokenVerificationResponse);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(String userId) async {
    try {
      List<Message> message = await authRemoteDataSource.getMessages(userId);
      return Right(message);
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getNewUser(creds) async {
    try {
      User newUser = await authRemoteDataSource.getNewUser(creds);
      return Right(newUser);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFriend(String uid) async {
    try {
      bool resp = await authRemoteDataSource.deleteFriend(uid);
      return Right(resp);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMessage(String messageId) async {
    try {
      bool resp = await authRemoteDataSource.deleteMessage(messageId);
      return Right(resp);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> reportMsg(String messageId) async {
    try {
      bool resp = await authRemoteDataSource.reportMessage(messageId);
      return Right(resp);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
