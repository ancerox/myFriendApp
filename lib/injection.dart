import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_friend/src/features/chat/data/datasource/login_remote_data_source.dart';
import 'package:my_friend/src/features/chat/data/repository/login_repository_impl.dart';
import 'package:my_friend/src/features/chat/domain/usecase/delete_friend.dart';
import 'package:my_friend/src/features/chat/domain/usecase/get_messages.dart';
import 'package:my_friend/src/features/chat/domain/usecase/get_new_user.dart';
import 'package:my_friend/src/features/chat/domain/usecase/token_verification_usecase.dart';

import 'src/features/chat/domain/repository/login_repository.dart';
import 'src/features/chat/domain/usecase/login_usecase.dart';
import 'src/features/chat/presentation/provider/message_provider.dart';
import 'src/features/chat/presentation/provider/providers.dart';

final locator = GetIt.instance;

void init() {
// Provider
  locator.registerFactory(() => AuthProvider(
      deleteFriendUseCase: locator(),
      loginUseCase: locator(),
      tokenVerificationUsecase: locator(),
      newUserUseCase: locator()));
  locator.registerFactory(
    () => MessageProvider(locator()),
  );

// UseCases
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => TokenVerification(locator()));
  locator.registerLazySingleton(() => GetMessagues(locator()));
  locator.registerLazySingleton(() => GetNewUser(locator()));
  locator.registerLazySingleton(() => DeleteFriend(locator()));

// repository
  locator.registerLazySingleton<ChatRepository>(
      () => AuthRepositoryIMPL(authRemoteDataSource: locator()));

  // Data sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceIMPL(dioClient: locator()),
  );

  locator.registerLazySingleton(() => Dio());
}
