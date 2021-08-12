import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/const.dart';
import 'package:flutter_app_shop_app/network/local/shared_preferences.dart';
import 'package:flutter_app_shop_app/shop_app/home/home_app_shop.dart';
import 'package:flutter_app_shop_app/shop_app/login_screen/cubit_login_screen/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/login_screen/resgister.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_login_screen/states.dart';

class SignInScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.setData(
                      key: "token", value: "${state.loginModel.data!.token}")
                  .then((value) {
                token = "${state.loginModel.data!.token}";
                print(state.loginModel.data!.token);
                showToastFunction(
                    msg: state.loginModel.message.toString(),
                    color: Colors.green,
                    context: context);
                navigatorToPush(context: context, screen: ShopAppLayout());
              }).catchError((err) {
                print(err);
              });
            } else {
              showToastFunction(
                  msg: state.loginModel.message.toString(),
                  color: Colors.red,
                  context: context);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: Center(
                          child: Text(
                            "Sign in with email and password\n   or continue with social media",
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      buildTextFormField(
                        textTitle: "Email",
                        hintText: "Enter your email here",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validatorText: "Please enter your email",
                        isObscureText: false,
                      ),
                      buildTextFormField(
                        onSubmit: (value) {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        textTitle: "Password",
                        hintText: "Enter your Password here",
                        icon: Icons.vpn_key,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        validatorText: "Please enter your Password",
                        isObscureText: LoginCubit.get(context).isVisibility,
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          icon: LoginCubit.get(context).icon,
                        ),
                      ),
                      buildButtonContinue(
                          context: context,
                          onTap: () {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          }),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have an account?   "),
                            InkWell(
                              onTap: () {
                                navigatorTo(
                                  context: context,
                                  screen: ResgisterScreen(),
                                );
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
