import "package:flutter/material.dart";
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/search/cubit/cubit.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/sates.dart';

class SearchLayout extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text("Search"),
                centerTitle: true,
              ),
              body: cubit.searchModel == null
                  ? Column(
                      children: [
                        buildTextFormField(
                          textTitle: "Search",
                          controller: searchController,
                          validatorText: "none",
                          hintText: "Enter name item u want",
                          icon: Icons.search,
                          keyboardType: TextInputType.text,
                          enabled: true,
                          isObscureText: false,
                          context: context,
                          radius: 0.0,
                          onSubmit: (value) {
                            cubit.postSearchData(value);
                          },
                        ),
                        if(state is AppLoadingSearchState)
                          LinearProgressIndicator()
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              var product =
                                  cubit.searchModel!.data!.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 120,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            "${product.image}",
                                            height: 120,
                                            width: 150,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            textBaseline:
                                                TextBaseline.alphabetic,
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
                                                    .postDataFavorites(
                                                        product.id);
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
                            itemCount: cubit.searchModel!.data!.data!.length,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                      ],
                    ));
        },
        listener: (context, state) {},
      ),
    );
  }
}
