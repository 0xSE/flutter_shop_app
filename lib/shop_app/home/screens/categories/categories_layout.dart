import "package:flutter/material.dart";
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesLayout extends StatelessWidget {
  const CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              leading: Image.network(
                "${cubit.categoriesModel!.data!.data[index].image}",
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              title: Text(
                "${cubit.categoriesModel!.data!.data[index].name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          },

          itemCount: cubit.categoriesModel!.data!.data.length,
        );
      },
    );
  }
}
