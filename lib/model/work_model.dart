// 作品模型类
import 'dart:convert';

class WorkResponse {
  final int code;
  final WorkData data;
  final String msg;

  WorkResponse({required this.code, required this.data, required this.msg});

  factory WorkResponse.fromJson(Map<String, dynamic> json) {
    return WorkResponse(
      code: json['code'] is int ? json['code'] : 0,
      data: WorkData.fromJson(json['data'] ?? {}),
      msg: json['msg'] ?? '',
    );
  }
}

class WorkData {
  final int total;
  final int pages;
  final List<WorkItem> list;

  WorkData({required this.total, required this.pages, required this.list});

  factory WorkData.fromJson(Map<String, dynamic> json) {
    return WorkData(
      total: json['total'] is int ? json['total'] : 0,
      pages: json['pages'] is int ? json['pages'] : 0,
      list: json['list'] is List
          ? (json['list'] as List)
                .map((item) => WorkItem.fromJson(item))
                .toList()
          : [],
    );
  }
}

class WorkItem {
  final List<String> images;
  final int postId;
  final String avatarUrl;
  final int userId;
  final String nickname;
  final String createdAt;
  final int likeCount;
  final String type;
  final String title;
  final String content;
  final int status;

  WorkItem({
    required this.images,
    required this.postId,
    required this.avatarUrl,
    required this.userId,
    required this.nickname,
    required this.createdAt,
    required this.likeCount,
    required this.type,
    required this.title,
    required this.content,
    required this.status,
  });

  factory WorkItem.fromJson(Map<String, dynamic> json) {
    // 处理images字段，可能是字符串或列表
    List<String> imagesList = [];
    if (json['images'] is String) {
      try {
        // 尝试解析JSON字符串
        imagesList = jsonDecode(json['images']);
      } catch (e) {
        // 如果解析失败，将整个字符串作为单个图片URL
        imagesList = [json['images']];
      }
    } else if (json['images'] is List) {
      imagesList = List<String>.from(json['images']);
    }

    return WorkItem(
      images: imagesList,
      postId: json['post_id'] is int ? json['post_id'] : 0,
      avatarUrl: json['avatar_url'] ?? '',
      userId: json['user_id'] is int ? json['user_id'] : 0,
      nickname: json['nickname'] ?? '',
      createdAt: json['created_at'] ?? '',
      likeCount: json['likeCount'] is int ? json['likeCount'] : 0,
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      status: json['status'] is int ? json['status'] : 0,
    );
  }
}
