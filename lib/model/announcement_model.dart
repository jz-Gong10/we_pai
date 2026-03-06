// 公告数据模型类
class AnnouncementItem {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final int type;
  final int status;

  AnnouncementItem({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.status,
  });

  factory AnnouncementItem.fromJson(Map<String, dynamic> json) {
    return AnnouncementItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      type: json['type'] ?? 1,
      status: json['status'] ?? 1,
    );
  }
}

class AnnouncementResponse {
  final int code;
  final List<AnnouncementItem> data;
  final String msg;

  AnnouncementResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementResponse(
      code: json['code'] ?? 0,
      data: (json['data'] as List?)
              ?.map((item) => AnnouncementItem.fromJson(item))
              .toList() ??
          [],
      msg: json['msg'] ?? '',
    );
  }
}
