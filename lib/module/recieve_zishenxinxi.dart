class UserInfo {
  int role;
  bool agreement;
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

  UserInfo({
    required this.role,
    required this.agreement,
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
      agreement: json['agreement'] ?? false,
      avatarUrl: json['avatarUrl'],
      sex: json['sex'],
      equipment: json['equipment'] != null
          ? List<String>.from(json['equipment'])
          : [],
      casId: json['casId'],
      phone: json['phone'],
      name: json['name'],
      nickname: json['nickname'],
      completedOrders: json['completedOrders'],
      style: json['style'] != null
          ? List<String>.from(json['style'])
          : [],
      detail: json['detail'],
      totalLikes: json['totalLikes'],
      totalOrders: json['totalOrders'],
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
      'equipment': equipment,
      'casId': casId,
      'phone': phone,
      'name': name,
      'nickname': nickname,
      'completedOrders': completedOrders,
      'style': style,
      'detail': detail,
      'totalLikes': totalLikes,
      'totalOrders': totalOrders,
      'photographerType': photographerType,
    };
  }

  @override
  String toString() {
    return 'UserInfo{role: $role, agreement: $agreement, avatarUrl: $avatarUrl, sex: $sex, equipment: $equipment, casId: $casId, phone: $phone, name: $name, nickname: $nickname, completedOrders: $completedOrders, style: $style, detail: $detail, totalLikes: $totalLikes, totalOrders: $totalOrders, photographerType: $photographerType}';
  }
}
