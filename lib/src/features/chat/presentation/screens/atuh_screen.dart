import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/presentation/provider/providers.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isUserAuth(context),
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(child: Text('loading')),
          );
        });
  }

  Future isUserAuth(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketService>(context, listen: false);

    final isAuth = await provider.tokenVerification();

    if (isAuth) {
      socketProvider.connect();

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      provider.logUserOut();
    }
  }
}
