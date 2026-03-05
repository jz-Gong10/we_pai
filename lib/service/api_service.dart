import 'package:dio/dio.dart';
import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';
import 'package:we_pai/module/sys_model.dart';
import '../module/recieve_zishenxinxi.dart';
import 'dio_service.dart';
import 'package:we_pai/service/dio_service.dart';
import 'package:we_pai/api/api_config.dart';
import 'package:we_pai/net/http.dart';
import 'package:flutter/material.dart';
import '../model/work_model.dart';
import '../module/recieve_sheyingshijiedan.dart';
import '../module/recieve_kedan.dart';
import '../module/recieve_sheyingshipingfen.dart';

class ApiService {
  final Dio _dio = DioService().dio;

  // 获得自身信息
  Future<UserInfo> getUserInfo() async {
    try {
      Response response = await _dio.get('/user/getProfile');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return UserInfo.fromJson(responseData['data']);
        } else {
          throw Exception('获取个人信息失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取个人信息失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取单个用户信息
  Future<UserInfo> getUserById(int id) async {
    try {
      Response response = await _dio.get('/user/info/$id');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return UserInfo.fromJson(responseData['data']);
        } else {
          throw Exception('获取用户失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取用户失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取摄影师列表
  Future<List<SYSList>> getPhotographers() async {
    try {
      Response response = await _dio.get(
        '/photographer/list',
        queryParameters: {'pageNum': '1', 'pageSize': '10', 'keyword': ''},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          SysModel sysModel = SysModel.fromJson(responseData['data']);
          return sysModel.phoList;
        } else {
          throw Exception('获取摄影师列表失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('个人信息接收失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  //获取用户预约订单列表
  Future<List<KedanOrder>> getKedan() async {
    try {
      Response response = await _dio.get('/order/photographer/pending');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          KedanList kedanList = KedanList.fromJson(responseData['data']);
          return kedanList.list;
        } else {
          throw Exception('获取用户预约订单列表失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取用户预约订单列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  //获取公告
  Future<List<String>> getAnnouncements() async {
    try {
      Response response = await _dio.get('/user/announcements');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return List<String>.from(responseData['data']);
        } else {
          throw Exception('获取公告失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取公告失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  //获取搜索历史
  Future<List<String>> getSearchHistory() async {
    try {
      Response response = await _dio.get('/photographer/search/history');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return List<String>.from(responseData['data']);
        } else {
          throw Exception('获取搜索历史失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取搜索历史失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  //搜索推荐词
  Future<List<String>> getSearchRecommendations() async {
    try {
      Response response = await _dio.get('/photographer/search/suggest');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return List<String>.from(responseData['data']);
        } else {
          throw Exception('获取搜索推荐词失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取搜索推荐词失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取摄影师订单列表排行榜
  Future<List<SYOrder>> getSYOrder() async {
    try {
      Response response = await _dio.get('/photographer/ranking/orders');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return List<SYOrder>.from(
            responseData['data'].map((item) => SYOrder.fromJson(item)),
          );
        } else {
          throw Exception('获取摄影师订单列表排行榜失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取摄影师订单列表排行榜失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  //获取摄影师评分排行榜
  Future<List<SYRate>> getSYRating() async {
    try {
      Response response = await _dio.get('/photographer/ranking/ratings');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return List<SYRate>.from(
            responseData['data'].map((item) => SYRate.fromJson(item)),
          );
        } else {
          throw Exception('获取摄影师评分排行榜失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取摄影师评分排行榜失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 错误处理
  Exception _handleDioError(DioException e) {
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

  // 更新用户资料
  Future<Map<String, dynamic>> updateUserProfile(
    Map<String, dynamic> profileData,
  ) async {
    try {
      // 过滤掉空值字段
      Map<String, dynamic> filteredData = {};
      profileData.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty) {
          filteredData[key] = value;
        }
      });

      Response response = await _dio.post(
        '/user/updateProfile',
        data: filteredData,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return responseData['data'] ?? {};
        } else {
          throw Exception('更新资料失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('更新资料失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取个人作品列表
  Future<WorkResponse> getMyWorks(
    int pageNum,
    int pageSize, {
    int? status,
  }) async {
    try {
      Response response = await _dio.get(
        '/square/my-posts',
        queryParameters: {
          'pageNum': pageNum,
          'pageSize': pageSize,
          if (status != null) 'status': status,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return WorkResponse.fromJson(responseData['data']);
        } else {
          throw Exception('获取作品列表失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('获取作品列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 提交问题反馈
  Future<Map<String, dynamic>> submitFeedback(
    String content,
    String contact,
    String image,
  ) async {
    try {
      Response response = await _dio.post(
        '/user/feedback',
        data: {'content': content, 'contact': contact, 'image': image},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['code'] == 200) {
          return responseData['data'] ?? {};
        } else {
          throw Exception('提交反馈失败: ${responseData['msg']}');
        }
      } else {
        throw Exception('提交反馈失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}
