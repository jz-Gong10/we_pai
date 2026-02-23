class SYSList {
  String avatarUrl;
  String casId;
  String nickname;
  String style;
  int orderCount;
  String type;

  SYSList({
    required this.avatarUrl,
    required this.casId,
    required this.nickname,
    required this.style,
    required this.orderCount,
    required this.type,
  });

  factory SYSList.fromJson(Map<String, dynamic> json) {
    return SYSList(
      avatarUrl: json['avatar_url'],
      casId: json['cas_d'],
      nickname: json['nickname'],
      style: json['style'],
      orderCount: json['order_count'],
      type: json['type'],
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
    };
  }

  @override
  String toString() {
    return 'UserInfo{avatarUrl: $avatarUrl,casId:$casId,nickname:$nickname,style:$style,orderCount:$orderCount,type:$type}';
  }
}
