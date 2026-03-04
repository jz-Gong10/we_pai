class SYRate {
  String avatarUrl;
  String nickname;
  double avgScore;
  String casId;
  String type;

  SYRate({
    required this.avatarUrl,
    required this.nickname,
    required this.avgScore,
    required this.casId,
    required this.type,
  });

  factory SYRate.fromJson(Map<String, dynamic> json) {
    return SYRate(
      avatarUrl: json['avatar_url'],
      nickname: json['nickname'],
      avgScore: json['avgScore'],
      casId: json['cas_id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'nickname': nickname,
      'avgScore': avgScore,
      'casId': casId,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'SYRate{avatarUrl: $avatarUrl, nickname: $nickname, avgScore: $avgScore, casId: $casId, type: $type}';
  }
}
