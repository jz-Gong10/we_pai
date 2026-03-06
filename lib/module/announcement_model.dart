// 公告模型类
class Announcement {
  final int id;
  final String title;
  final String content;
  final int type;
  final int status;
  final String createdAt;
  final String updatedAt;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
