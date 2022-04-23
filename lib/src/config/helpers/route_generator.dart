import 'package:flutter/material.dart';
import 'package:my_friend/src/features/chat/presentation/screens/contact_us_page.dart';
import 'package:my_friend/src/features/chat/presentation/screens/screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/login':
        // Validation of correct data type

        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/chat':
        return MaterialPageRoute(builder: (_) => const MessagePage());
      case '/contactus':
        return MaterialPageRoute(builder: (_) => const ContactUsPage());
      // If there is no such named route in the switch statement, e.g. /third
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
