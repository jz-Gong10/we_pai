class UserDetailResponse {
  int? code;
  UserDetailData? data;
  String? msg;

  UserDetailResponse({this.code, this.data, this.msg});

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailResponse(
      code: json['code'] is int
          ? json['code']
          : int.tryParse(json['code']?.toString() ?? '0'),
      data: json['data'] != null ? UserDetailData.fromJson(json['data']) : null,
      msg: json['msg']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'data': data?.toJson(), 'msg': msg};
  }
}

class UserDetailData {
  int? role;
  bool? agreement;
  String? avatarUrl;
  int? sex;
  int? orderCount;
  List<String>? equipment;
  double? averageScore;
  String? casId;
  String? phone;
  String? nickname;
  int? completedOrders;
  List<String>? style;
  String? detail;
  int? totalLikes;
  int? totalOrders;
  List<String>? photographerType;

  UserDetailData({
    this.role,
    this.agreement,
    this.avatarUrl,
    this.sex,
    this.orderCount,
    this.equipment,
    this.averageScore,
    this.casId,
    this.phone,
    this.nickname,
    this.completedOrders,
    this.style,
    this.detail,
    this.totalLikes,
    this.totalOrders,
    this.photographerType,
  });

  factory UserDetailData.fromJson(Map<String, dynamic> json) {
    return UserDetailData(
      role: json['role'] is int
          ? json['role']
          : int.tryParse(json['role']?.toString() ?? '0'),
      agreement: json['agreement'],
      avatarUrl: json['avatarUrl']?.toString(),
      sex: json['sex'] is int
          ? json['sex']
          : int.tryParse(json['sex']?.toString() ?? '0'),
      orderCount: json['orderCount'] is int
          ? json['orderCount']
          : int.tryParse(json['orderCount']?.toString() ?? '0'),
      equipment: json['equipment'] != null
          ? List<String>.from(json['equipment'])
          : [],
      averageScore: json['averageScore'] is double
          ? json['averageScore']
          : double.tryParse(json['averageScore']?.toString() ?? '0.0'),
      casId: json['casId']?.toString(),
      phone: json['phone']?.toString(),
      nickname: json['nickname']?.toString(),
      completedOrders: json['completedOrders'] is int
          ? json['completedOrders']
          : int.tryParse(json['completedOrders']?.toString() ?? '0'),
      style: json['style'] != null ? List<String>.from(json['style']) : [],
      detail: json['detail']?.toString(),
      totalLikes: json['totalLikes'] is int
          ? json['totalLikes']
          : int.tryParse(json['totalLikes']?.toString() ?? '0'),
      totalOrders: json['totalOrders'] is int
          ? json['totalOrders']
          : int.tryParse(json['totalOrders']?.toString() ?? '0'),
      photographerType: json['photographerType'] != null
          ? List<String>.from(json['photographerType'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'agreement': agreement,
      'avatarUrl': avatarUrl,
      'sex': sex,
      'orderCount': orderCount,
      'equipment': equipment,
      'averageScore': averageScore,
      'casId': casId,
      'phone': phone,
      'nickname': nickname,
      'completedOrders': completedOrders,
      'style': style,
      'detail': detail,
      'totalLikes': totalLikes,
      'totalOrders': totalOrders,
      'photographerType': photographerType,
    };
  }
}
