import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';

class Work extends StatelessWidget {
  final String avatarUrl;
  final String nickname;
  final String description;
  final List<String> imageUrls;
  final int likes;
  final int comments;
  final Function()? onLike;
  final Function()? onComment;
  final Function()? onDelete;

  const Work({
    Key? key,
    required this.avatarUrl,
    required this.nickname,
    required this.description,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    this.onLike,
    this.onComment,
    this.onDelete,
  }) : super(key: key);

  // 查看大图
  void _viewImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth - 40;
    final avatarSize = 48.0;
    final imageSize = (containerWidth - 16) / 3;

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: lhGradient,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像和昵称
          Row(
            children: [
              Container(//头像
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                nickname,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // 描述文本，与头像左边界对齐
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 16),
          // 图片网格
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: imageUrls.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _viewImage(context, imageUrls[index]),
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(//点赞
                    onTap: onLike,
                    child: Container(
                      width: 24,
                      height: 24,
                      child: const Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('$likes'),
                ],
              ),
              Row(
                children: [
                  GestureDetector(//评论
                    onTap: onComment,
                    child: Container(
                      width: 24,
                      height: 24,
                      child: const Icon(
                        Icons.comment_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('$comments'),
                ],
              ),
              GestureDetector(//删除
                onTap: onDelete,
                child: Container(
                  width: 24,
                  height: 24,
                  child: const Icon(
                    Icons.delete_outline,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
