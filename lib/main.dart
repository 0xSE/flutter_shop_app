import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/const.dart';
import 'package:flutter_app_shop_app/network/http_service/api_dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network/local/shared_preferences.dart';
import 'shop_app/home/home_app_shop.dart';
import 'shop_app/login_screen/sigin_in.dart';
import 'shop_app/on_boarding/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  late bool? onBoarding;
  onBoarding = CacheHelper.getData(key: "onBoarding") ?? null;
  token = CacheHelper.getData(key: "token") ?? null;
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = ShopAppLayout();
    else
      widget = SignInScreen();
  } else
    widget = SplashScreen();
  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  final widget;

  const MyApp({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.deepOrange),
      ),
    );
  }
}
