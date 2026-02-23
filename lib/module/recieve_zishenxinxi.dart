class UserInfo {
  int role;
  String avatarUrl;
  int sex;
  String equipment;
  String casId;
  String phone;
  String name;
  String nickname;
  int completedOrders;
  String style;
  String detail;
  int totalLikes;
  int totalOrders;
  String photographerType;

  UserInfo({
    required this.role,
    required this.avatarUrl,
    required this.sex,
    required this.equipment,
    required this.casId,
    required this.phone,
    required this.name,
    required this.nickname,
    required this.completedOrders,
    required this.style,
    required this.detail,
    required this.totalLikes,
    required this.totalOrders,
    required this.photographerType,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      role: json['role'],
      avatarUrl: json['avatarUrl'],
      sex: json['sex'],
      equipment: json['equipment'],
      casId: json['casId'],
      phone: json['phone'],
      name: json['name'],
      nickname: json['nickname'],
      completedOrders: json['completedOrders'],
      style: json['style'],
      detail: json['detail'],
      totalLikes: json['totalLikes'],
      totalOrders: json['totalOrders'],
      photographerType: json['photographerType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'avatarUrl': avatarUrl,
      'sex': sex,
      'equipment': equipment,
      'casId': casId,
      'phone': phone,
      'name': name,
      'nickname': nickname,
      'completedOrders': completedOrders,
      'style': style,
      'detail': detail,
      'totalOrders': totalOrders,
      'photographerType': photographerType,
    };
  }

  @override
  String toString() {
    return 'UserInfo{role : $role,avatarUrl: $avatarUrl,sex: $sex,equipment: $equipment,casId:$casId,phone:$phone,name:$name,nickname:$nickname,completedOrders:$completedOrders,style:$style,detial:$detail,totalOrders:$totalOrders,photographerType:$photographerType}';
  }
}
