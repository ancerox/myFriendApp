import 'package:flutter/material.dart';
import 'package:my_friend/src/features/chat/presentation/screens/screens.dart';
import 'package:provider/provider.dart';

import 'src/features/chat/presentation/provider/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(),
        home: MessagePage(),
        // darkTheme: darkThemeData(context),
      ),
    );
  }
}
