// 作品模型类
import 'dart:convert';

class WorkResponse {
  final int code;
  final WorkData data;
  final String msg;

  WorkResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory WorkResponse.fromJson(Map<String, dynamic> json) {
    return WorkResponse(
      code: json['code'],
      data: WorkData.fromJson(json['data']),
      msg: json['msg'],
    );
  }
}

class WorkData {
  final int total;
  final int pages;
  final List<WorkItem> list;

  WorkData({
    required this.total,
    required this.pages,
    required this.list,
  });

  factory WorkData.fromJson(Map<String, dynamic> json) {
    return WorkData(
      total: json['total'],
      pages: json['pages'],
      list: (json['list'] as List).map((item) => WorkItem.fromJson(item)).toList(),
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
      postId: json['post_id'],
      avatarUrl: json['avatar_url'],
      userId: json['user_id'],
      nickname: json['nickname'],
      createdAt: json['created_at'],
      likeCount: json['likeCount'],
      type: json['type'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
    );
  }
}

class WorkDetailResponse {
  final int code;
  final WorkDetailData data;
  final String msg;

  WorkDetailResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory WorkDetailResponse.fromJson(Map<String, dynamic> json) {
    return WorkDetailResponse(
      code: json['code'],
      data: WorkDetailData.fromJson(json['data']),
      msg: json['msg'],
    );
  }
}

class WorkDetailData {
  final List<String> images;
  final bool role;
  final int isLiked;
  final String createdAt;
  final String type;
  final String title;
  final String content;
  final int postId;
  final String avatarUrl;
  final int userId;
  final String nickname;
  final int totalLikes;
  final int status;

  WorkDetailData({
    required this.images,
    required this.role,
    required this.isLiked,
    required this.createdAt,
    required this.type,
    required this.title,
    required this.content,
    required this.postId,
    required this.avatarUrl,
    required this.userId,
    required this.nickname,
    required this.totalLikes,
    required this.status,
  });

  factory WorkDetailData.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['images'] is String) {
      try {
        imagesList = jsonDecode(json['images']);
      } catch (e) {
        imagesList = [json['images']];
      }
    } else if (json['images'] is List) {
      imagesList = List<String>.from(json['images']);
    }

    return WorkDetailData(
      images: imagesList,
      role: json['role'] ?? false,
      isLiked: json['isLiked'] ?? 0,
      createdAt: json['created_at'],
      type: json['type']?.toString() ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      postId: json['post_id'],
      avatarUrl: json['avatar_url'] ?? '',
      userId: json['user_id'],
      nickname: json['nickname'] ?? '',
      totalLikes: json['totalLikes'] ?? 0,
      status: json['status'] ?? 1,
    );
  }
}

class CommentResponse {
  final int code;
  final CommentData data;
  final String msg;

  CommentResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      code: json['code'],
      data: CommentData.fromJson(json['data']),
      msg: json['msg'],
    );
  }
}

class CommentData {
  final int total;
  final int pages;
  final List<CommentItem> list;

  CommentData({
    required this.total,
    required this.pages,
    required this.list,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 1,
      list: (json['list'] as List?)?.map((item) => CommentItem.fromJson(item)).toList() ?? [],
    );
  }
}

class CommentItem {
  final int postId;
  final String avatarUrl;
  final String userId;
  final String nickname;
  final String createdAt;
  final int id;
  final String content;

  CommentItem({
    required this.postId,
    required this.avatarUrl,
    required this.userId,
    required this.nickname,
    required this.createdAt,
    required this.id,
    required this.content,
  });

  factory CommentItem.fromJson(Map<String, dynamic> json) {
    return CommentItem(
      postId: json['post_id'],
      avatarUrl: json['avatar_url'] ?? '',
      userId: json['user_id']?.toString() ?? '',
      nickname: json['nickname'] ?? '',
      createdAt: json['created_at'],
      id: json['id'],
      content: json['content'] ?? '',
    );
  }
}
