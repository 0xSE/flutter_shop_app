import "package:flutter/material.dart";
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesLayout extends StatelessWidget {
  const FavoritesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            body: cubit.favoritesProductsModel == null
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (context, index) {
                      var product = cubit
                          .favoritesProductsModel!.data!.data![index].product!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    "${product.image}",
                                    height: 120,
                                    width: 150,
                                    fit: BoxFit.contain,
                                  ),
                                  if (product.oldPrice != product.price)
                                    Positioned(
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade400,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "DISCOUNT",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      bottom: 2,
                                    )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 210,
                                    child: Text(
                                      "${product.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        "LE ${product.price}",
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      if (product.oldPrice != product.price)
                                        Text(
                                          "LE ${product.oldPrice}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            textBaseline:
                                                TextBaseline.ideographic,
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        AppCubit.get(context)
                                            .postDataFavorites(product.id);
                                      },
                                      icon: Icon(
                                        AppCubit.get(context)
                                                .favoritesMap["${product.id}"]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.deepOrange,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.favoritesProductsModel!.data!.data!.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.red,
                      );
                    },
                  ));
      },
      listener: (context, state) {},
    );
  }
}
