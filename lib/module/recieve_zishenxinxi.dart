class UserInfo {
  int? role;
  String? avatarUrl;
  int? sex;
  List<String>? equipment;
  String? casId;
  String? phone;
  String? name;
  String? nickname;
  int? completedOrders;
  List<String>? style;
  String? detail;
  int? totalLikes;
  int? totalOrders;
  List<String>? photographerType;
  bool? agreement;

  UserInfo({
    this.role,
    this.avatarUrl,
    this.sex,
    this.equipment,
    this.casId,
    this.phone,
    this.name,
    this.nickname,
    this.completedOrders,
    this.style,
    this.detail,
    this.totalLikes,
    this.totalOrders,
    this.photographerType,
    this.agreement,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      role: json['role'],
      agreement: json['agreement'] ?? false,
      avatarUrl: json['avatarUrl'],
      sex: json['sex'],
      equipment: json['equipment'] != null
          ? List<String>.from(json['equipment'])
          : null,
      casId: json['casId'],
      phone: json['phone'],
      name: json['name'],
      nickname: json['nickname'],
      completedOrders: json['completedOrders'],
      style: json['style'] != null ? List<String>.from(json['style']) : null,
      detail: json['detail'],
      totalLikes: json['totalLikes'],
      totalOrders: json['totalOrders'],
      photographerType: json['photographerType'] != null
          ? List<String>.from(json['photographerType'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'agreement': agreement,
      'casId': casId,
      'phone': phone,
      'name': name,
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
    return 'UserInfo{role: $role, avatarUrl: $avatarUrl, sex: $sex, equipment: $equipment, casId: $casId, phone: $phone, name: $name, nickname: $nickname, completedOrders: $completedOrders, style: $style, detail: $detail, totalLikes: $totalLikes, totalOrders: $totalOrders, photographerType: $photographerType, agreement: $agreement}';
  }
}