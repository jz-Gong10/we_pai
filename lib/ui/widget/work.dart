//用来展示作品的（包含描述文本和9张图片）
import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/page/comments.dart';

class Work extends StatefulWidget {
  final int postId;
  final String avatarUrl;
  final String nickname;
  final String description;
  final List<String> imageUrls;
  final int likes;
  final int comments;
  final bool isLiked;
  final String type; // 'all' or 'my' or 'sb'
  //all,sb没有删除，my有删除
  final Gradient? gradient; // lhGradient或者pinkGradient
  final VoidCallback? onRefresh;

  const Work({
    super.key,
    required this.postId,
    required this.avatarUrl,
    required this.nickname,
    required this.description,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    required this.type,
    this.gradient,
    this.onRefresh,
  });

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  final ApiService _apiService = ApiService();
  late int _currentLikes;
  late int _currentComments;
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.likes;
    _currentComments = widget.comments;
    _isLiked = widget.isLiked;
  }

  // 查看大图
  void _viewImage(BuildContext context, String imageUrl) {
    if (imageUrl.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.image_not_supported, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  // 点赞/取消点赞
  Future<void> _handleLike() async {
    try {
      if (_isLiked) {
        //?
        await _apiService.unlikePost(widget.postId);
        setState(() {
          _isLiked = false;
          _currentLikes--;
        });
      } else {
        await _apiService.likePost(widget.postId);
        setState(() {
          _isLiked = true;
          _currentLikes++;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('操作失败: $e')));
      }
    }
  }

  // 查看评论
  Future<void> _handleComment() async {
    try {
      // 获取评论列表
      final commentResponse = await _apiService.getComments(widget.postId);
      if (commentResponse.code == 200) {
        // 转换评论数据类型
        final comments = commentResponse.data.list.map((item) {
          return CommentItem(
            avatarUrl: item.avatarUrl,
            nickname: item.nickname,
            content: item.content,
            createdAt: item.createdAt,
          );
        }).toList();
        // 跳转到评论页面，传递 postId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Comments(comments: comments, postId: widget.postId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('获取评论失败: ${commentResponse.msg}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('获取评论失败: $e')));
    }
  }

  // 删除帖子
  Future<void> _handleDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这个作品吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _apiService.deletePost(widget.postId);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('删除成功')));
        }
        widget.onRefresh?.call();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('删除失败: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth - 40;
    final avatarSize = 48.0;
    final imageSize = (containerWidth - 16) / 3;

    final borderColor = widget.gradient == lhGradient ? Colors.black : primary3;

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: widget.gradient ?? lhGradient,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像和昵称
          Row(
            children: [
              Container(
                //头像
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200],
                  image: widget.avatarUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(widget.avatarUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: widget.avatarUrl.isEmpty
                    ? Icon(Icons.person, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                widget.nickname,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // 描述文本
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 14),
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
            itemCount: widget.imageUrls.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final imageUrl = widget.imageUrls[index];
              return GestureDetector(
                onTap: () =>
                    imageUrl.isNotEmpty ? _viewImage(context, imageUrl) : null,
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                    image: imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl.isEmpty
                      ? Icon(Icons.image_not_supported, color: Colors.grey)
                      : null,
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
                  GestureDetector(
                    //点赞
                    onTap: _handleLike, //点赞逻辑，写在上面
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        _isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        size: 20,
                        color: _isLiked ? Colors.red : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('$_currentLikes'),
                ],
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _handleComment, //评论逻辑，写在上面
                    icon: const Icon(Icons.comment_outlined, size: 20),
                    label: Text('$_currentComments'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                  ),
                ],
              ),
              if (widget.type != 'all' && widget.type != 'sb') //只有自己可以删除
                GestureDetector(
                  //删除
                  onTap: _handleDelete, //删除逻辑，写在上面
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.delete_outline, size: 20),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
