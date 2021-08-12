import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_login_screen/cubit.dart';
import 'cubit_login_screen/states.dart';

class ResgisterScreen extends StatelessWidget {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessRegisterState) {
            if (state.isSuccess == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Success Register')),
              );
              return Navigator.pop(context);
            }
          }else{
            print(state.toString());
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
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
                body: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Register Account",
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
                            child: Column(
                              children: [
                                Text(
                                  "Complete your details or continue",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic),
                                  maxLines: 2,
                                ),
                                Center(
                                  child: Text(
                                    "with social media",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(
                          textTitle: "Name",
                          controller: _nameController,
                          validatorText: "Pls enter your name.",
                          hintText: "Enter your name here",
                          icon: Icons.account_box,
                          keyboardType: TextInputType.name,
                          isObscureText: false,
                        ),
                        buildTextFormField(
                          textTitle: "Phone",
                          hintText: "Enter your Phone here",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          validatorText: "Please enter your phone",
                          isObscureText: false,
                        ),
                        buildTextFormField(
                          textTitle: "Email",
                          hintText: "Enter your email here",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validatorText: "Please enter your email",
                          isObscureText: false,
                        ),
                        buildTextFormField(
                          // onSubmit: (value) {
                          //   LoginCubit.get(context).userLogin(
                          //       email: _emailController.text,
                          //       password: _passwordController.text);
                          // },
                          textTitle: "Password",
                          hintText: "Enter your Password here",
                          icon: Icons.vpn_key,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          validatorText: "Please enter your Password",
                          isObscureText: LoginCubit.get(context).isVisibility,
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: LoginCubit.get(context).icon,
                          ),
                        ),
                        buildButtonContinue(
                          context: context,
                          onTap: () {
                            LoginCubit.get(context).userRegister(
                              email: _emailController.text,
                              name: _nameController.text,
                              phone: _phoneController.text,
                              password: _passwordController.text,
                            );
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
