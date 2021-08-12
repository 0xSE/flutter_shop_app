import "package:flutter/material.dart";
import 'package:flutter_app_shop_app/network/local/shared_preferences.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_app_shop_app/shop_app/login_screen/sigin_in.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsLayout extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessUpdateState) {
          if (state.data.status == true) {
            showToastFunction(
                msg: state.data.message.toString(),
                color: Colors.green,
                context: context);
          } else {
            showToastFunction(
                msg: state.data.message.toString(),
                color: Colors.red,
                context: context);
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        nameController.text = cubit.profile!.data!.name ?? '';
        phoneController.text = cubit.profile!.data!.phone ?? '';
        emailController.text = cubit.profile!.data!.email ?? '';
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is AppLoadingUpdateState  || state is AppChangeEnabledState)
                  LinearProgressIndicator(color: Colors.deepOrange,),
                SizedBox(height: 20,),
                buildTextFormField(
                  radius: 0.0,
                  icon: Icons.drive_file_rename_outline,
                  validatorText: "Name can't be embty",
                  context: context,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  hintText: "Enter your name here",
                  textTitle: "Name",
                  enabled: cubit.isEnabled,
                  isObscureText: false,
                ),
                buildTextFormField(
                  radius: 0.0,
                  icon: Icons.email,
                  validatorText: "Email can't be embty",
                  context: context,
                  keyboardType: TextInputType.name,
                  controller: emailController,
                  hintText: "Enter your Email here",
                  textTitle: "Email",
                  enabled: cubit.isEnabled,
                  isObscureText: false,
                ),
                buildTextFormField(
                  radius: 0.0,
                  icon: Icons.phone,
                  validatorText: "Phone can't be embty",
                  context: context,
                  keyboardType: TextInputType.name,
                  controller: phoneController,
                  hintText: "Enter your phone here",
                  textTitle: "Phone",
                  enabled: cubit.isEnabled,
                  isObscureText: false,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrange)),
                    onPressed: () {
                      CacheHelper.removeData(key: "token");
                      navigatorToPush(context: context, screen: SignInScreen());
                    },
                    child: Text("LOGOUT")),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrange)),
                    onPressed: () {
                      if (cubit.isEnabled == false)
                        cubit.changeEnabled();
                      else {
                        cubit.postDataUpdate(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                        cubit.changeEnabled();
                      }
                    },
                    child: Text(
                        cubit.isEnabled == false ? "Update Profile" : "Done")),
              ],
            ),
          ),
        );
      },
    );
  }
}
