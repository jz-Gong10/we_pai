import 'package:dio/dio.dart';
import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';
import 'package:we_pai/module/sys_model.dart';
import '../module/recieve_zishenxinxi.dart';
import 'dio_service.dart';
import 'package:we_pai/service/dio_service.dart';
import 'package:we_pai/api/api_config.dart';
import 'package:we_pai/net/http.dart';
import 'package:flutter/material.dart';
import 'package:we_pai/module/model.dart';

class ApiService {
  final Dio _dio = DioService().dio;

  // 获得自身信息
  Future<UserInfo> getUserInfo() async {
    try {
      Response response = await _dio.get('/user/getProfile');
      if (response.statusCode == 200) {
        return UserInfo.fromJson(response.data); //传回来的只有data里的东西
      } else {
        throw Exception('获取个人信息失败: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取单个用户信息
  Future<UserInfo> getUserById(int id) async {
    try {
      Response response = await _dio.get('/user/info/{casId}');

      if (response.statusCode == 200) {
        return UserInfo.fromJson(response.data);
      } else {
        throw Exception('获取用户失败: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取摄影师列表
  Future<List<SYSList>> getPhotographers() async {
    try {
      Response response = await _dio.get(
        '/photographer/list',
        data: {'pageNum': '1', 'pageSize': '10', 'keyword': ''},
      );

      if (response.statusCode == 200) {
        SysModel responseData = response.data;
        List<dynamic> listData = responseData.phoList;
        return listData.map<SYSList>((json) {
          return SYSList.fromJson(json);
        }).toList();
      } else {
        throw Exception('个人信息接收失败: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  // 错误处理
  Exception _handleDioError(DioError e) {
    String message = e.message ?? '未知错误';

    if (e.response != null) {
      message =
          '服务器错误: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      // 可以尝试从响应体中获取更详细的错误信息
      if (e.response?.data != null && e.response?.data is Map) {
        message = e.response?.data['message'] ?? message;
      }
    }

    return Exception(message);
  }
}
