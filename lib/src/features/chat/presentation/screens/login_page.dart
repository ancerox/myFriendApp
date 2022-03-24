import 'package:flutter/material.dart';
import 'package:my_friend/src/config/helpers/alerts.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';

import 'package:my_friend/src/features/chat/presentation/components/auth_image.dart';

import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/providers.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passTextcontroller = TextEditingController();
  final emailTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketService>(context);

    // if (emailTextcontroller.text.isNotEmpty) {
    //   authProvider.validator();
    // }

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const AuthText(
                text: 'Log in',
              ),
              const RegisterImage(),
              CustomImput(
                onChanged: (String email) {
                  setState(() => authProvider.mail = email);
                },
                obscureText: false,
                prefixIcon: const Icon(Icons.email),
                hintText: 'Email',
                textEditingController: emailTextcontroller,
                key: const Key('emailImput'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomImput(
                onChanged: (String password) {
                  setState(() => authProvider.pass = password);
                },
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
                hintText: 'PassWord',
                textEditingController: passTextcontroller,
                key: const Key('passwordimput'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ...List.generate(
                authProvider.errorList.length,
                (index) => Errors(text: authProvider.errorList[index]),
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomBtn(
                onPressed: authProvider.pass.isNotEmpty &&
                        authProvider.mail.isNotEmpty
                    ? () async {
                        authProvider.validator();
                        if (authProvider.errorList.isEmpty) {
                          final isAtuh = await authProvider.login(
                              email: authProvider.mail,
                              password: authProvider.pass);

                          if (isAtuh) {
                            authProvider.mail = '';
                            authProvider.pass = '';

                            socketProvider.connect();
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            showCustomAlert(context, 'Wrong email or password',
                                'duble check');
                          }
                        }
                      }
                    : null,
                text: 'Log In',
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You don't have an acount yet?"),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('Register',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
