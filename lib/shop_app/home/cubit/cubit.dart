import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_shop_app/models/favorites_model.dart';
import 'package:flutter_app_shop_app/models/favorites_model_List.dart';
import 'package:flutter_app_shop_app/models/get_categories_model.dart';
import 'package:flutter_app_shop_app/models/home_model.dart';
import 'package:flutter_app_shop_app/models/model_login_plage/model_sing_up.dart';
import 'package:flutter_app_shop_app/models/search_model.dart';
import 'package:flutter_app_shop_app/network/end_points.dart';
import 'package:flutter_app_shop_app/network/http_service/api_dio.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/states.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/categories/categories_layout.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/favorites/favorites_layout.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/home/home_layout.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/settings/sttings_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../const.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeLayout(),
    CategoriesLayout(),
    FavoritesLayout(),
    SettingsLayout(),
  ];
  int currentIndex = 0;

  void changeBottomNavPage(int index) {
    currentIndex = index;
    emit(changeBottomNavPageState());
  }

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<String, dynamic> favoritesMap = {};

  void getDataHome() {
    emit(AppLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favoritesMap.addAll({
          "${element.id}": element.inFavorites,
        });
      });

      emit(AppSuccessHomeState());
    }).catchError((onError) {
      print(onError);
      emit(AppErrorHomeState());
    });
  }

  void getDataCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppSuccessCategoriesState());
    }).catchError((onError) {
      print(onError);
      emit(AppErrorCategoriesState());
    });
  }

  FavoritesProductsModel? favoritesProductsModel;

  void getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesProductsModel = FavoritesProductsModel.fromJson(value.data);
      emit(AppSuccessFavoritesListState());
    }).catchError((onError) {
      print(onError);
      emit(AppErrorFavoritesListState());
    });
  }

  ShopLoginModel? profile;

  void getProfile() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profile = ShopLoginModel.fromJson(value.data);
      emit(AppSuccessProfileState());
    }).catchError((onError) {
      print(onError);
      emit(AppErrorProfileState());
    });
  }

  FavoritesModel? favorites;

  void postDataFavorites(id) {
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      lang: 'en',
      data: {"product_id": id},
    ).then((value) {
      favorites = FavoritesModel.fromJson(value.data);
      if (favorites!.status == false) {
      } else {
        favoritesMap.update("$id", (value) {
          if (value == true)
            return value = false;
          else
            return value = true;
        });
        getFavorites();
        emit(AppAddSuccessFavoritesState(favorites!.message));
      }
    }).catchError((onError) {
      print(onError);
      emit(AppAddErrorFavoritesState());
    });
  }

  ShopLoginModel? updateData;
  bool isEnabled = false;

  void postDataUpdate({required name, required phone, required email}) {
    emit(AppLoadingUpdateState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      lang: 'en',
      data: {
        "name": name,
        "phone": phone,
        "email": email,
      },
    ).then((value) {
      profile = ShopLoginModel.fromJson(value.data);
      updateData = ShopLoginModel.fromJson(value.data);
      emit(AppSuccessUpdateState(updateData));
    }).catchError((onError) {
      print(onError);
      emit(AppErrorUpdateState());
    });
  }

  void changeEnabled() {
    isEnabled = !isEnabled;
    emit(AppChangeEnabledState());
  }

}
