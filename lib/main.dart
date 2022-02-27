import 'package:flutter/material.dart';
import 'package:my_friend/src/config/themes/themes.dart';
import 'package:my_friend/src/features/chat/presentation/screens/login_page.dart';

import 'src/features/chat/presentation/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(),
      home: LoginPage(),
      darkTheme: darkThemeData(context),
    );
  }
}
