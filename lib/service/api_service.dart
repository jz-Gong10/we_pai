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

class ApiService {
  final Dio _dio = DioService().dio;

  // 获得自身信息
  Future<UserInfo> getUserInfo() async {
    try {
      Response response = await _dio.get('/user/getProfile');//获取自身信息
      if (response.statusCode == 200) {
        return UserInfo.fromJson(response.data); 
      } else {
        throw Exception('获取自身信息失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取单个用户信息
  Future<UserInfo> getUserById(int id) async {
    try {
      Response response = await _dio.get('/user/info/{casId}');//获取用户(casId信息)

      if (response.statusCode == 200) {
        return UserInfo.fromJson(response.data);
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
        data: {'pageNum': '1', 'pageSize': '10', 'keyword': ''},
      );

      if (response.statusCode == 200) {
        SysModel responseData = response.data;
        List<dynamic> listData = responseData.phoList;
        return listData.map<SYSList>((json) {
          return SYSList.fromJson(json);
        }).toList();
      } else {
        throw Exception('获取摄影师列表失败: ${response.statusCode}');
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

  // 获取个人作品列表
  Future<WorkResponse> getMyWorks(int pageNum, int pageSize, {int? status}) async {
    try {
      Response response = await _dio.get('/square/my-posts', queryParameters: {//获取自身帖子
        'pageNum': pageNum,
        'pageSize': pageSize,
        if (status != null) 'status': status,
      });

      if (response.statusCode == 200) {
        return WorkResponse.fromJson(response.data);
      } else {
        throw Exception('获取个人作品列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取所有作品列表
  Future<WorkResponse> getAllWorks(int pageNum, int pageSize) async {
    try {
      Response response = await _dio.get('/square/posts', queryParameters: {
        'pageNum': pageNum,
        'pageSize': pageSize,
      });

      if (response.statusCode == 200) {
        return WorkResponse.fromJson(response.data);
      } else {
        throw Exception('获取所有作品列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 点赞
  Future<void> likePost(int postId) async {
    try {
      Response response = await _dio.post('/square/like/$postId');
      if (response.statusCode != 200) {
        throw Exception('点赞失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 取消点赞
  Future<void> unlikePost(int postId) async {
    try {
      Response response = await _dio.post('/square/unlike/$postId');
      if (response.statusCode != 200) {
        throw Exception('取消点赞失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 评论
  Future<void> commentPost(int postId, String content) async {
    try {
      Response response = await _dio.post('/square/comment', data: {
        'postId': postId,
        'content': content,
      });
      if (response.statusCode != 200) {
        throw Exception('评论失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 删除帖子
  Future<void> deletePost(int postId) async {
    try {
      Response response = await _dio.delete('/square/posts/$postId');
      if (response.statusCode != 200) {
        throw Exception('删除帖子失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取作品详情
  Future<WorkDetailResponse> getWorkDetail(int postId) async {
    try {
      Response response = await _dio.get('/square/detail/$postId');

      if (response.statusCode == 200) {
        return WorkDetailResponse.fromJson(response.data);
      } else {
        throw Exception('获取作品详情失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 获取评论列表
  Future<CommentResponse> getComments(int postId) async {
    try {
      Response response = await _dio.get('/square/comments/$postId');

      if (response.statusCode == 200) {
        return CommentResponse.fromJson(response.data);
      } else {
        throw Exception('获取评论列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}
