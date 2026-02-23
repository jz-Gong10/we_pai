import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Http {
  //请求的基础地址
  final String baseUrl = "http://127.0.0.1:4523/m1/7790878-7537573-default";
  final Duration connectTimeout = Duration(seconds: 10);
  final Duration receiveTimeout = Duration(seconds: 10);

  //token
  String _token = "";

  //Dio实例
  late final Dio _dio;

  //单例
  static Http? _instance;

  //工厂构造函数,返回唯一实例
  //使用时直接调用 Http() 即可获取实例，不深研究也没关系
  factory Http() {
    return _getInstance();
  }

  static Http _getInstance() {
    if (_instance == null) {
      _instance = Http._internal();
      //初始化Dio
      _instance!._dio = Dio(
        BaseOptions(
          baseUrl: _instance!.baseUrl,
          connectTimeout: _instance!.connectTimeout,
          receiveTimeout: _instance!.receiveTimeout,
        ),
      );

      //添加拦截器
      _instance!._dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            //请求之前的处理
            if (_instance!._token.isNotEmpty) {
              //添加token，需要看后端的要求
              options.headers['Authorization'] = 'Bearer ${_instance!._token}';
            }
            return handler.next(options);
          },
          onResponse: (response, handler) {
            //响应数据处理
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            //错误处理
            if (e.response?.statusCode == 401) {
              //处理未授权错误，例如跳转到登录页、刷新token等
              debugPrint("${e.response?.statusCode}");
            } else if (e.response?.statusCode == 500) {
              //处理服务器错误
              debugPrint("${e.response?.statusCode}");
            }

            return handler.next(e);
          },
        ),
      );

      // 日志
      _instance!._dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          error: true,
        ),
      );

      return _instance!;
    } else {
      return _instance!;
    }
  }

  //Dart中的私有构造函数
  Http._internal();

  /// GET请求
  Future<Response<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST请求
  Future<Response<T>> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  //设置token
  void setToken(String token) {
    _token = token;
  }
}
