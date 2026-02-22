//查询草稿列表的接口调用方法

import 'dart:convert';
import 'package:we_pai/net/http.dart' as http;
import 'package:we_pai/model/draft_model.dart';

class ApiService {
  // 接口地址（替换为实际地址）
  static const String baseUrl = 'http://127.0.0.1:4523/m1/7790878-7537573-default';

  static Future<DraftResponse> fetchDraftList(int pageNum, int pageSize) async {
    final url = '$baseUrl/order/draft/getList?pageNum=$pageNum&pageSize=$pageSize';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return DraftResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('接口请求失败：${response.statusCode}');
    }
  }
}