import 'package:flutter/material.dart';
import 'package:my_friend/src/config/constants.dart';
import 'package:my_friend/src/config/screen_size.dart';

import 'package:my_friend/src/features/chat/presentation/components/componets.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final nameTextcontroller = TextEditingController();
  final emailTextcontroller = TextEditingController();
  final passTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'My Friend',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: SizeConfig.heightSize(context, 5.0),
              ),
              const RegisterImage(),
              SizedBox(
                height: SizeConfig.heightSize(context, 5.0),
              ),
              CustomImput(
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
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
                hintText: 'PassWord',
                textEditingController: passTextcontroller,
                key: const Key('passwordimput'),
              ),
              SizedBox(
                height: SizeConfig.heightSize(context, 5.0),
              ),
              const CustomBtn(text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterImage extends StatelessWidget {
  const RegisterImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('registerimage'),
      width: SizeConfig.widthSize(context, 70.0),
      child: const Image(
        fit: BoxFit.fill,
        image: AssetImage('assets/icons/Texting-pana.png'),
      ),
    );
  }
}
