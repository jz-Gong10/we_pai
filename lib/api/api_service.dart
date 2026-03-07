import 'dart:convert';
import 'package:we_pai/net/http.dart';
import 'package:we_pai/model/draft_model.dart';

//查询草稿列表的接口调用方法
class ApiEnquiry {
  static Future<DraftResponse> fetchDraftList(int pageNum, int pageSize) async {
    // 调用http.dart中Http的get方法，通过queryParameters传递参数
    final response = await Http().get(
      path: '/order/draft/getList', // 接口路径
      queryParameters: {'pageNum': pageNum, 'pageSize': pageSize},
    );

    // 检查响应状态码
    if (response.statusCode == 200) {
      // 解析JSON数据并返回 DraftResponse
      final dynamic body = response.data is String
          ? json.decode(response.data)
          : response.data;
      return DraftResponse.fromJson(body);
    } else {
      // 尝试解析错误响应
      try {
        final dynamic errorData = response.data is String
            ? json.decode(response.data)
            : response.data;
        String errorMsg = errorData['msg'] ?? '服务器错误，请稍后重试';
        return DraftResponse(
          code: response.statusCode ?? 500,
          data: DraftData(total: 0, pages: 0, list: []),
          msg: errorMsg,
        );
      } catch (e) {
        // 解析失败，返回默认错误
        return DraftResponse(
          code: response.statusCode ?? 500,
          data: DraftData(total: 0, pages: 0, list: []),
          msg: '服务器错误，请稍后重试',
        );
      }
    }
  }
}

//提交草稿的接口调用方法
class ApiPost {
  static Future<DraftResponse> createOrder(Map<String, dynamic> data) async {
    final response = await Http().post(path: '/order/create', data: data);

    if (response.statusCode == 200) {
      final dynamic body = response.data is String
          ? json.decode(response.data)
          : response.data;
      return DraftResponse.fromJson(body);
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}

//保存草稿的接口调用方法
class ApiSave {
  static Future<DraftResponse> saveOrder(Map<String, dynamic> data) async {
    final response = await Http().post(path: '/order/draft/save', data: data);

    if (response.statusCode == 200) {
      final dynamic body = response.data is String
          ? json.decode(response.data)
          : response.data;
      return DraftResponse.fromJson(body);
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}

//获取草稿详细信息的接口调用方法
class ApiDetail {
  static Future<DraftResponse> fetchDraftDetail(int orderId) async {
    // 调用http.dart中Http的get方法，通过queryParameters传递参数
    final response = await Http().get(
      path: '/order/draft/getDetail',
      queryParameters: {'orderId': orderId},
    );

    // 检查响应状态码
    if (response.statusCode == 200) {
      // 解析JSON数据并返回 DraftResponse
      final dynamic body = response.data is String
          ? json.decode(response.data)
          : response.data;
      return DraftResponse.fromJson(body);
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}

//删除草稿的接口调用方法
class ApiDelete {
  static Future<DraftResponse> deleteDraft(int orderId) async {
    final response = await Http().delete(path: '/order/draft/delete/$orderId');

    if (response.statusCode == 200) {
      final dynamic body = response.data is String
          ? json.decode(response.data)
          : response.data;
      return DraftResponse.fromJson(body);
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}
