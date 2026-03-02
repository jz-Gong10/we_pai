//定义数据类型：DraftModel和DraftResponse类
//获取草稿列表
class DraftModel {
  final int OrderId;
  final String location;
  final String createdAt;

  DraftModel({
    required this.OrderId,
    required this.location,
    required this.createdAt,
  });

  factory DraftModel.fromJson(Map<String, dynamic> json) {
    return DraftModel(
      OrderId: json['OrderId'],
      location: json['location'],
      createdAt: json['createdAt'],
    );
  }
}

class DraftResponse {
  final int code;
  final DraftData data;
  final String msg;

  DraftResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory DraftResponse.fromJson(Map<String, dynamic> json) {
    return DraftResponse(
      code: json['code'],
      data: DraftData.fromJson(json['data']),
      msg: json['msg'],
    );
  }
}

class DraftData {
  final int total;
  final int pages;
  final List<DraftModel> list;

  DraftData({required this.total, required this.pages, required this.list});

  factory DraftData.fromJson(Map<String, dynamic> json) {
    return DraftData(
      total: json['total'],
      pages: json['pages'],
      list: List<DraftModel>.from(
        json['list']?.map((item) => DraftModel.fromJson(item)) ?? [],
      ),
    );
  }
}

  