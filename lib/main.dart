import 'package:flutter/material.dart';
import 'package:my_friend/injection.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/domain/usecase/get_messages.dart';
import 'package:my_friend/src/features/chat/domain/usecase/report_msg.dart';
import 'package:my_friend/src/features/chat/domain/usecase/token_verification_usecase.dart';
import 'package:my_friend/src/features/chat/presentation/provider/message_provider.dart';
import 'package:provider/provider.dart';

import 'src/config/helpers/route_generator.dart';
import 'src/features/chat/domain/usecase/delete_friend.dart';
import 'src/features/chat/domain/usecase/delete_message.dart';
import 'src/features/chat/domain/usecase/get_new_user.dart';
import 'src/features/chat/domain/usecase/login_usecase.dart';
import 'src/features/chat/presentation/provider/providers.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider(
                deleteFriendUseCase: locator<DeleteFriend>(),
                newUserUseCase: locator<GetNewUser>(),
                loginUseCase: locator<LoginUseCase>(),
                tokenVerificationUsecase: locator<TokenVerification>())),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(
            create: (_) => MessageProvider(
                  reportMsgUseCase: locator<ReportMsg>(),
                  deleteMessageUsecase: locator<DeleteMessage>(),
                  getMessagesUseCase: locator<GetMessagues>(),
                )),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        // darkTheme: darkThemeData(context),
      ),
    );
  }
}
