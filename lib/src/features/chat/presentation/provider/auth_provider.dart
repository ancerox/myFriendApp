import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter/widgets.dart';
import 'package:my_friend/src/config/error/failure.dart';
import 'package:my_friend/src/config/helpers/save_token.dart';
import 'package:my_friend/src/config/usecase/usecase.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/domain/usecase/login_usecase.dart';
import 'package:my_friend/src/features/chat/domain/usecase/token_verification_usecase.dart';

class AuthProvider extends ChangeNotifier {
  User? friend;
  bool isAuthing = false;
  User? user;
  String name = '';
  String mail = '';
  String pass = '';
  List<String> errorList = [];
  final LoginUseCase loginUseCase;
  final TokenVerification tokenVerificationUsecase;

  AuthProvider(
      {required this.loginUseCase, required this.tokenVerificationUsecase});

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

    // Name validator

    // PassWord Validator
    if (pass.length >= 6) {
      errorList.remove(passWordError);
    }

    if (errorList.contains(passWordError)) return;

    if (pass.length < 6) {
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
  }

  Future<bool> login({required email, required password}) async {
    isAuthing = true;
    Either<Failure, User> result = await loginUseCase.call(
      Params(
        login: LoginResponse(email: email, password: password),
      ),
    );

    return result.fold((l) => false, (user) {
      this.user = user;
      isAuthing = false;
      return true;
    });
  }

  Future tokenVerification() async {
    Either<Failure, User> result =
        await tokenVerificationUsecase.call(NoParams());

    return result.fold((l) => false, (user) {
      this.user = user;
      return true;
    });
  }

  logUserOut() async {
    deleteToken();
  }
}
