import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? _dio;
  static final baseUrl = "https://student.valuxapps.com/api/";

  static init() {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl, receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    @required String? token,
  }) async {
    _dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': "application/json",
    };
    return await _dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    _dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': "application/json",
    };
    return await _dio!.post(url, queryParameters: query, data: data);
  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    _dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': "application/json",
    };
    return await _dio!.put(url, queryParameters: query, data: data);
  }
}
