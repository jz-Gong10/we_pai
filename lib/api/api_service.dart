
import 'dart:convert';
import 'package:we_pai/net/http.dart'; 
import 'package:we_pai/model/draft_model.dart'; 

//查询草稿列表的接口调用方法
class ApiEnquiry {
  static const String baseUrl = 'http://127.0.0.1:4523/m1/7790878-7537573-default';

  static Future<DraftResponse> fetchDraftList(int pageNum, int pageSize) async {
    // 调用http.dart中Http的get方法，通过queryParameters传递参数
    final response = await Http().get(
      path: '/order/draft/getList', // 接口路径
      queryParameters: {
        'pageNum': pageNum,
        'pageSize': pageSize,
      },
    );

    // 检查响应状态码
    if (response.statusCode == 200) {
      // 解析JSON数据并返回 DraftResponse
      return DraftResponse.fromJson(json.decode(response.data));
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}

//提交草稿的接口调用方法
class ApiPost {
  static const String baseUrl = 'http://127.0.0.1:4523/m1/7790878-7537573-default';
  
  static Future<DraftResponse> createOrder(Map<String, dynamic> data) async {
    final response = await Http().post(
      path: '/order/create',
      data: data,
    );

    if (response.statusCode == 200) {
      final dynamic body = response.data is String ? json.decode(response.data) : response.data;
      return DraftResponse.fromJson(body);
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}

//保存草稿的接口调用方法
class ApiSave {
  static const String baseUrl = 'http://127.0.0.1:4523/m1/7790878-7537573-default';
  
  static Future<DraftResponse> saveOrder(Map<String, dynamic> data) async {
    final response = await Http().post(
      path: '/order/draft/save',
      data: data,
    );

    if (response.statusCode == 200) {
      final dynamic body = response.data is String ? json.decode(response.data) : response.data;
      return DraftResponse.fromJson(body);
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}

//获取草稿详细信息的接口调用方法
class ApiDetail {
  static const String baseUrl = 'http://127.0.0.1:4523/m1/7790878-7537573-default';

  static Future<DraftResponse> fetchDraftDetail(int orderId) async {
    // 调用http.dart中Http的get方法，通过queryParameters传递参数
    final response = await Http().get(
      path: '/order/draft/getDetail', 
      queryParameters: {
        'orderId': orderId,
      },
    );

    // 检查响应状态码
    if (response.statusCode == 200) {
      // 解析JSON数据并返回 DraftResponse
      return DraftResponse.fromJson(json.decode(response.data));
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}