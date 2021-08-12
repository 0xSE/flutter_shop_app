import "package:flutter/material.dart";
import 'package:flutter_app_shop_app/network/local/shared_preferences.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/search/search_layout.dart';
import 'package:flutter_app_shop_app/shop_app/login_screen/sigin_in.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getDataHome()
        ..getProfile()
        ..getDataCategories()
        ..getFavorites(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "STORM",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        navigatorTo(context: context, screen: SearchLayout());
                      },
                      icon: Icon(Icons.search))
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey[600],
                onTap: (index) {
                  cubit.changeBottomNavPage(index);
                },
                showUnselectedLabels: true,
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category_outlined), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],

            );
          },
          listener: ((context, state) {})),
    );
  }
}
