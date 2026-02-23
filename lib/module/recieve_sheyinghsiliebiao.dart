class SYSList {
  String avatarUrl;
  String casId;
  String nickname;
  List<String> style;
  int orderCount;
  List<String> type;
  List<String> equipment;

  SYSList({
    required this.avatarUrl,
    required this.casId,
    required this.nickname,
    required this.style,
    required this.orderCount,
    required this.type,
    required this.equipment,
  });

  factory SYSList.fromJson(Map<String, dynamic> json) {
    return SYSList(
      avatarUrl: json['avatar_url'],
      casId: json['cas_d'],
      nickname: json['nickname'],
      orderCount: json['order_count'],
      equipment: List<String>.from(json['equipment'] ?? []),
      style: List<String>.from(json['style'] ?? []),
      type: List<String>.from(json['type'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'casId': casId,
      'nickname': nickname,
      'style': style,
      'orderCount': orderCount,
      'type': type,
      'equipment': equipment,
    };
  }

  @override
  String toString() {
    return 'UserInfo{avatarUrl: $avatarUrl,casId:$casId,nickname:$nickname,style:$style,orderCount:$orderCount,type:$type,equipment:$equipment}';
  }
}
