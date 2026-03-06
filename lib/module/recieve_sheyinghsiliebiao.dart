class SYSList {
  String? avatarUrl;
  String? casId;
  String? nickname;
  List<String>? style;
  int? orderCount;
  List<String>? type;
  List<String>? equipment;

  SYSList({
    this.avatarUrl,
    this.casId,
    this.nickname,
    this.style,
    this.orderCount,
    this.type,
    this.equipment,
  });

  factory SYSList.fromJson(Map<String, dynamic> json) {
    return SYSList(
      avatarUrl: json['avatar_url']?.toString(),
      casId: json['cas_id']?.toString(),
      nickname: json['nickname']?.toString(),
      orderCount: json['order_count'] is int
          ? json['order_count']
          : int.tryParse(json['order_count']?.toString() ?? '0'),
      equipment: json['equipment'] != null
          ? List<String>.from(json['equipment'])
          : [],
      style: json['style'] != null ? List<String>.from(json['style']) : [],
      type: json['type'] != null ? List<String>.from(json['type']) : [],
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
