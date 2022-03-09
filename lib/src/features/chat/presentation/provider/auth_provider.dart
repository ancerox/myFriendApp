import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  String name = '';
  String mail = '';
  String pass = '';
  List<String> errorList = [];

  void validator() {
    notifyListeners();

    const errorName = 'A name is required';
    const passWordError = 'The password must have 8 caracters';
    const mailError = 'The email is not valid';

    // Name validator
    if (name.isNotEmpty) {
      errorList.remove(errorName);
    }

    if (errorList.contains(errorName)) return;

    if (name.isEmpty) {
      errorList.add(errorName);
    }

    // Name validator
    //
    // PassWord Validator
    if (pass.length >= 8) {
      errorList.remove(passWordError);
    }

    if (errorList.contains(passWordError)) return;

    if (pass.length < 8) {
      errorList.add(passWordError);
    }
    // PassWord Validator
    //
    // Email Validator
    final emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (emailValid.hasMatch(mail)) {
      errorList.remove(mailError);
    }

    if (errorList.contains(mailError)) return;

    if (!emailValid.hasMatch(mail)) {
      errorList.add(mailError);
    }
    // Email Validator

    if (errorList.isEmpty) {
      print('do this');
    }
  }
}
