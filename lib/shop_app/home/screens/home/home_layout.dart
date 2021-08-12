import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_app_shop_app/models/get_categories_model.dart';
import 'package:flutter_app_shop_app/models/home_model.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.homeModel != null
              ? productsBuilder(cubit.homeModel, cubit.categoriesModel, context)
              : Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {
        if (state is AppAddSuccessFavoritesState) {
          showToastFunction(
            color: Colors.green,
            context: context,
            msg: "${state.message}",
          );
        }
      },
    );
  }
}

Widget productsBuilder(
        HomeModel? model, CategoriesModel? categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data!.banners
                .map(
                  (e) => Image.network(
                    "${e.image}",
                    fit: BoxFit.contain,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              reverse: false,
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: 3),
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              initialPage: 0,
            ),
          ),
          Text(
            "Categories",
            style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 150,
                          width: 200,
                          color: Colors.white,
                          child: Image.network(
                            "${categoriesModel!.data!.data[index].image}",
                            fit: BoxFit.contain,
                            height: 150,
                            width: 200,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 100,
                          color: Colors.black.withOpacity(0.8),
                          child: Center(
                            child: Text(
                              "${categoriesModel.data!.data[index].name}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 10),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Products",
            style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
          ),
          InkWell(
            onTap: () => print("product"),
            child: Container(
              color: Colors.grey,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.37,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildProductItem(model.data!.products[index], context)),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildProductItem(ProductModel model, context) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              Image.network(
                "${model.image}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              Positioned(
                right: 3,
                child: IconButton(
                  onPressed: () {
                    AppCubit.get(context).postDataFavorites(model.id);
                  },
                  icon: Icon(
                    AppCubit.get(context).favoritesMap["${model.id}"]
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.deepOrange,
                    size: 30,
                  ),
                ),
              ),
              if (model.oldPrice != model.price)
                Positioned(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  bottom: 2,
                )
            ],
          ),
        ),
        Expanded(
          child: Text(
            "${model.name}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1.3),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "LE ${model.price}",
              style: TextStyle(color: Colors.deepOrange, fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            if (model.oldPrice != model.price)
              Text(
                "LE ${model.oldPrice}",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  textBaseline: TextBaseline.ideographic,
                ),
              ),
          ],
        )
      ],
    ),
  );
}

