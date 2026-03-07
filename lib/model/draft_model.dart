//定义数据类型：DraftModel和DraftResponse类
//获取草稿列表
class DraftModel {
  final int? orderId;
  final String? customerId;
  final String? photographerId;
  final String? type;
  final String? shootTime;
  final String? duration;
  final String? location;
  final int? subjectCount;
  final double? price;
  final bool? needEquipment;
  final String? contactInfo;
  final String? remark;
  final int? status;
  final String? paymentStatus;
  final String? deliverUrl;
  final String? createdAt;

  DraftModel({
    this.orderId,
    this.customerId,
    this.photographerId,
    this.type,
    this.shootTime,
    this.duration,
    this.location,
    this.subjectCount,
    this.price,
    this.needEquipment,
    this.contactInfo,
    this.remark,
    this.status,
    this.paymentStatus,
    this.deliverUrl,
    this.createdAt,
  });

  factory DraftModel.fromJson(Map<String, dynamic> json) {
    return DraftModel(
      orderId: json['orderId'],
      customerId: json['customerId'],
      photographerId: json['photographerId'],
      type: json['type'],
      shootTime: json['shootTime'],
      duration: json['duration'],
      location: json['location'],
      subjectCount: json['subjectCount'],
      price: json['price']?.toDouble(),
      needEquipment: json['needEquipment'],
      contactInfo: json['contactInfo'],
      remark: json['remark'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      deliverUrl: json['deliverUrl'],
      createdAt: json['createdAt'],
    );
  }
}

class DraftResponse {
  final int code;
  final dynamic data;
  final String msg;

  DraftResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory DraftResponse.fromJson(Map<String, dynamic> json) {
    return DraftResponse(
      code: json['code'],
      data: json['data'] is List ? DraftData.fromJson(json['data']) : DraftModel.fromJson(json['data']),
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

  