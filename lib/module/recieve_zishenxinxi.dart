class UserInfo {
  int role;
  String avatarUrl;
  int sex;
  List<String> equipment;
  String casId;
  String phone;
  String name;
  String nickname;
  int completedOrders;
  List<String> style;
  String detail;
  int totalLikes;
  int totalOrders;
  List<String> photographerType;
  bool agreement;

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
    required this.agreement,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      role: json['role'],
      avatarUrl: json['avatarUrl'],
      sex: json['sex'],
      equipment: List<String>.from(json['equipment']),
      casId: json['casId'],
      phone: json['phone'],
      name: json['name'],
      nickname: json['nickname'],
      completedOrders: json['completedOrders'],
      style: List<String>.from(json['style']),
      detail: json['detail'],
      totalLikes: json['totalLikes'],
      totalOrders: json['totalOrders'],
      photographerType: List<String>.from(json['photographerType']),
      agreement: json['agreement'],
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
      'agreement': agreement,
    };
  }

  @override
  String toString() {
    return 'UserInfo{role: $role, avatarUrl: $avatarUrl, sex: $sex, equipment: $equipment, casId: $casId, phone: $phone, name: $name, nickname: $nickname, completedOrders: $completedOrders, style: $style, detail: $detail, totalLikes: $totalLikes, totalOrders: $totalOrders, photographerType: $photographerType, agreement: $agreement}';
  }
}
