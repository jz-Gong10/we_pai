import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/themes/colors.dart';

class Comments extends StatefulWidget {
  final List<CommentItem> comments;

  const Comments({super.key, required this.comments});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 20, left: 23, right: 23, child: UpEdge(title: '评论')),

          // 评论列表
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                final comment = widget.comments[index];
                return CommentItem(
                  avatarUrl: comment.avatarUrl,
                  nickname: comment.nickname,
                  content: comment.content,
                  createdAt: comment.createdAt,
                );
              },
            ),
          ),
        ],
      ),
    );
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
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // 右下角：评论时间
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                createdAt,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
