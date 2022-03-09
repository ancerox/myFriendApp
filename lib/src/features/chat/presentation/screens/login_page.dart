import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';

import 'package:my_friend/src/features/chat/presentation/components/auth_image.dart';

import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/components/errors_widget.dart';
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
                onPressed:
                    authProvider.pass.isNotEmpty && authProvider.mail.isNotEmpty
                        ? authProvider.validator
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
                    onPressed: () {},
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
