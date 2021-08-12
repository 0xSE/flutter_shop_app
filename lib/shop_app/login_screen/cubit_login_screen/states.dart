import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_app_shop_app/models/model_login_plage/model_sing_up.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

//Sign up
class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final ShopLoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {}

class LoginVisibilityPasswordState extends LoginStates {}

//Sign in
class LoginLoadingRegisterState extends LoginStates {}

class LoginSuccessRegisterState extends LoginStates {
  final isSuccess;

  LoginSuccessRegisterState(this.isSuccess);
}

class LoginErrorRegisterState extends LoginStates {}
