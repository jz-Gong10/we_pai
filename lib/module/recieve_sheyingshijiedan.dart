class SYOrder {
  String avatarUrl;
  String nickname;
  int orderCount;
  String casId;
  String type;

  SYOrder({
    required this.avatarUrl,
    required this.nickname,
    required this.orderCount,
    required this.casId,
    required this.type,
  });

  factory SYOrder.fromJson(Map<String, dynamic> json) {
    return SYOrder(
      avatarUrl: json['avatar_url'],
      nickname: json['nickname'],
      orderCount: json['orderCount'],
      casId: json['cas_id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'nickname': nickname,
      'orderCount': orderCount,
      'casId': casId,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'SYOrder{avatarUrl: $avatarUrl, nickname: $nickname, orderCount: $orderCount, casId: $casId, type: $type}';
  }
}
