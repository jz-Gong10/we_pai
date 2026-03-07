import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/service/api_service.dart';

class Comments extends StatefulWidget {
  final List<CommentItem> comments;
  final int postId;

  const Comments({super.key, required this.comments, required this.postId});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController _commentController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isSubmitting = false;
  List<CommentItem> _comments = [];

  @override
  void initState() {
    super.initState();
    // 初始化评论列表
    _comments = List.from(widget.comments);
  }

  Future<void> _submitComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // 调用评论接口，使用从参数中获取的 postId
      await _apiService.commentPost(widget.postId, content);

      // 评论成功后，创建新的评论对象并添加到列表
      final newComment = CommentItem(
        avatarUrl: '', // 实际应该从用户信息中获取
        nickname: '我', // 实际应该从用户信息中获取
        content: content,
        createdAt: '刚刚', // 实际应该使用当前时间
      );

      // 更新评论列表
      setState(() {
        _comments.insert(0, newComment); // 将新评论添加到列表开头
        _commentController.clear(); // 清空输入框
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('评论成功')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('评论失败: $e')));
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 40, left: 23, right: 23, child: UpEdge(title: '评论')),

          // 评论列表
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 80, // 留出底部输入框的空间
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return CommentItem(
                  avatarUrl: comment.avatarUrl,
                  nickname: comment.nickname,
                  content: comment.content,
                  createdAt: comment.createdAt,
                );
              },
            ),
          ),

          // 底部输入框
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: '写下你的评论...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: primary3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: primary3, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitComment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text('评论'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

// 单个评论组件
class CommentItem extends StatelessWidget {
  final String avatarUrl;
  final String nickname;
  final String content;
  final String createdAt;

  const CommentItem({
    super.key,
    required this.avatarUrl,
    required this.nickname,
    required this.content,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: pinkGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary3, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部：头像和昵称
            Row(
              children: [
                // 头像
                ClipOval(
                  child: Image.network(
                    avatarUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // 昵称
                Text(
                  nickname,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 中间：评论内容
            Text(
              content,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 10),

            // 右下角：评论时间
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                createdAt,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
