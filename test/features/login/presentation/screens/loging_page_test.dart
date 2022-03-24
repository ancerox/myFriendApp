import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_friend/src/features/chat/presentation/components/errors_widget.dart';
import 'package:my_friend/src/features/chat/presentation/provider/providers.dart';
import 'package:my_friend/src/features/chat/presentation/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  group('LogIn Page Tests', () {
    testWidgets('User email imput', (WidgetTester tester) async {
      // Widgets Needed
      final emailImput = find.byKey(const ValueKey('emailImput'));

      // Execute the test

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(emailImput, 'This a test');

      // expected result
      expect(find.text('This a test'), findsOneWidget);
    });

    testWidgets('User PassWord Imput', (WidgetTester tester) async {
      // Widgets Needed
      final passWord = find.byKey(const ValueKey('passwordimput'));

      // Execute the test

      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      await tester.enterText(passWord, '123123');

      // expected result
      expect(find.text('123123'), findsOneWidget);
    });

    testWidgets('login Btn', (WidgetTester tester) async {
      // Widgets Needed

      final loginButton = find.byKey(const ValueKey('button'));

      // Execute the test
      String mail = 'winstonF@outlook.es';
      String pass = '123123';

      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
          child: const MaterialApp(home: LoginPage()),
        ),
      );
      //expects the button is unable
      expect(tester.widget<TextButton>(loginButton).enabled, isFalse);

      await tester.enterText(find.byKey(const Key('emailImput')), mail);
      await tester.enterText(find.byKey(const Key('passwordimput')), pass);

      await tester.tap(loginButton);
      await tester.ensureVisible(loginButton);
      await tester.pumpAndSettle(
        const Duration(milliseconds: 100),
      );

      // expected result
      expect(tester.widget<TextButton>(loginButton).enabled, isTrue);
    });
    testWidgets('Should return an image ', (WidgetTester tester) async {
      // Widgets Needed
      final registerimage = find.byKey(const ValueKey('registerimage'));

      // Execute the test

      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // expected result
      expect(registerimage, findsOneWidget);
    });
  });

  testWidgets('Should return button ', (WidgetTester tester) async {
    // Widgets Needed
    final registerimage = find.text('Register');

    // Execute the test

    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    await tester.tap(registerimage);

    // expected result
    expect(registerimage, findsOneWidget);
  });

  testWidgets('Should return erros ', (WidgetTester tester) async {
    // Widgets Needed
    final errorList = ['Error'];

    await tester.pumpWidget(MaterialApp(
        home: Errors(
      text: errorList[0],
    )));

    final errorWidget = find.byKey(const Key('errorswidget'));

    expect(errorWidget, findsOneWidget);

    // Execute the test
  });
}
