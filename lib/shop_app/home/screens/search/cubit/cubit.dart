import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/const.dart';
import 'package:flutter_app_shop_app/models/favorites_model.dart';
import 'package:flutter_app_shop_app/models/model_login_plage/model_sing_up.dart';
import 'package:flutter_app_shop_app/models/search_model.dart';
import 'package:flutter_app_shop_app/network/end_points.dart';
import 'package:flutter_app_shop_app/network/http_service/api_dio.dart';
import 'package:flutter_app_shop_app/network/local/shared_preferences.dart';
import 'package:flutter_app_shop_app/shop_app/home/screens/search/cubit/sates.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void postSearchData(text) {
    emit(AppLoadingSearchState());

    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token,
      lang: 'en',
      data: {"text": text},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(AppSuccessSearchState());
    }).catchError((onError) {
      print(onError);
      emit(AppErrorSearchState());
    });
  }
}
