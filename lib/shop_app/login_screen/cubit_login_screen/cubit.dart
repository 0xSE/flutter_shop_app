import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/const.dart';
import 'package:flutter_app_shop_app/models/model_login_plage/model_sing_up.dart';
import 'package:flutter_app_shop_app/network/end_points.dart';
import 'package:flutter_app_shop_app/network/http_service/api_dio.dart';
import 'package:flutter_app_shop_app/network/local/shared_preferences.dart';
import 'package:flutter_app_shop_app/shop_app/login_screen/cubit_login_screen/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var isVisibility = true;
  var icon = Icon(Icons.visibility_off);

  void changePasswordVisibility() {
    isVisibility == true ? isVisibility = false : isVisibility = true;
    icon = isVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    print(isVisibility);
    emit(LoginVisibilityPasswordState());
  }

  void userLogin({@required email, @required password}) {
    emit(LoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {"email": email, "password": password})
        .then((value) {
      var loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((onError) {
      print(onError.toString() + "in Login page postData");
      emit(LoginErrorState());
    });
  }

  void userRegister(
      {@required email, @required password, @required name, @required phone}) {
    emit(LoginLoadingRegisterState());

    DioHelper.postData(url: REGISTER, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": "https://student.valuxapps.com/storage/assets/defaults/user.jpg",
    }).then((value) {
      print(value.data["status"]);
      emit(LoginSuccessRegisterState(value.data["status"]));
    }).catchError((onError) {
      print(onError.toString() + "in Register page postData");
      emit(LoginErrorRegisterState());
    });
  }
}
