import 'package:dio/dio.dart';
import '../module/recieve_zishenxinxi.dart';
import 'dio_service.dart';
import 'package:we_pai/service/dio_service.dart';
import 'package:we_pai/api/api_config.dart';

class ApiService {
  final Dio _dio = DioService().dio;

  // 获得自身信息
  Future<UserInfo> getUserInfo() async {
    try {
      Response response = await _dio.get('/user/getProfile');
      Map<String, dynamic> responseData = response.data;
      int code = responseData['code'] ?? 0;
      String msg = responseData['msg'] ?? 0;
      if (code == 200) {
        Map<String, dynamic> data = responseData['data'];
        return UserInfo.fromJson(data); //传回来的只有data里的东西
      } else {
        throw Exception('获取个人信息失败: $msg');
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
  Future<List<UserInfo>> getPhotographers() async {
    try {
      Response response = await _dio.get('/photographer/list');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => UserInfo.fromJson(json)).toList();
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
