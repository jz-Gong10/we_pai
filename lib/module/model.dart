/// 通用API响应数据模型
class ApiResponse<T> {
  final int code;
  final T data;
  final String msg;

  ApiResponse({required this.code, required this.data, required this.msg});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse<T>(
      code: json['code'],
      data: fromJsonT(json['data']),
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'data': data, 'msg': msg};
  }
}

/// 空数据模型（用于data为空数组的情况）
class EmptyData {
  EmptyData();

  factory EmptyData.fromJson(dynamic json) {
    return EmptyData();
  }
}
