import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:my_friend/src/config/helpers/alerts.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/presentation/components/auth_image.dart';

import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/providers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameTextcontroller = TextEditingController();

  final emailTextcontroller = TextEditingController();

  final passTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketService>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightSize(context, 5.0),
              ),
              const AuthText(
                text: 'My Friend',
              ),
              const RegisterImage(),
              SizedBox(
                height: SizeConfig.heightSize(context, 5.0),
              ),
              CustomImput(
                onChanged: (name) {
                  setState(() => authProvider.name = name);
                },
                obscureText: false,
                prefixIcon: const Icon(Icons.person),
                hintText: 'Name',
                textEditingController: nameTextcontroller,
                key: const Key('nameImput'),
              ),
              SizedBox(
                height: SizeConfig.heightSize(context, 2.0),
              ),
              CustomImput(
                onChanged: (email) {
                  setState(() => authProvider.mail = email);
                },
                obscureText: false,
                prefixIcon: const Icon(Icons.email),
                hintText: 'Email',
                textEditingController: emailTextcontroller,
                key: const Key('emailImput'),
              ),
              SizedBox(
                height: SizeConfig.heightSize(context, 2.0),
              ),
              CustomImput(
                onChanged: (password) {
                  setState(() => authProvider.pass = password);
                },
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
                hintText: 'PassWord',
                textEditingController: passTextcontroller,
                key: const Key('passwordimput'),
              ),
              SizedBox(
                height: SizeConfig.heightSize(context, 2.0),
              ),
              ...List.generate(
                authProvider.errorList.length,
                (index) => Errors(text: authProvider.errorList[index]),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: authProvider.isUserAgreeWithTerms,
                    onChanged: (value) {
                      setState(() {
                        authProvider.isUserAgreeWithTerms = value;
                      });
                    },
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: 'By creating this account i agree EULA terms \n'),
                    TextSpan(
                        text: 'Read about EULA terms here',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                'https://github.com/ancerox/EULA-AGREEMENT-MyFriend/blob/main/LICENSE.md');
                          })
                  ])),
                ],
              )),
              CustomBtn(
                onPressed: authProvider.pass.isNotEmpty &&
                        authProvider.mail.isNotEmpty &&
                        authProvider.name.isNotEmpty &&
                        authProvider.isUserAgreeWithTerms == true
                    ? () async {
                        authProvider.validator();
                        if (authProvider.errorList.isEmpty) {
                          final user = await authProvider.newUser();

                          if (user) {
                            authProvider.mail = '';
                            authProvider.pass = '';
                            socketProvider.connect();
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            showCustomAlert(context, 'Server error',
                                'This email may be in use');
                          }
                        }
                      }
                    : null,
                text: 'Register',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You already have an acount?"),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text("Log In",
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
