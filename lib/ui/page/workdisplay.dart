//作品展示，目前做成了最新发布的展示在最上面，用摄影实践圈的数据，图片只展示第一张，砍掉了描述文本
import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/zhuye_low_edge.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/post.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/model/work_model.dart'; //作品数据模型

class WorkDisplay extends StatefulWidget {
  const WorkDisplay({super.key});

  @override
  State<WorkDisplay> createState() => _WorkDisplayState();
}

class _WorkDisplayState extends State<WorkDisplay> {
  final ApiService _apiService = ApiService();
  List<WorkItem> _works = [];
  // 存储每个作品的点赞状态和当前点赞数
  Map<int, bool> _isLikedMap = {};
  Map<int, int> _likeCountMap = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWorks();
  }

  Future<void> _loadWorks() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await _apiService.getAllWorks(1, 10);
      //使用apiservice调用getAllWorks接口获取作品列表
      setState(() {
        // 过滤掉无效数据
        _works = response.data.list.where((work) {
          // 确保有图片和必要的字段
          return work.images != null &&
              work.images.isNotEmpty &&
              work.createdAt != null &&
              work.avatarUrl != null &&
              work.nickname != null;
        }).toList();

        // 按时间排序，最新的在前
        _works.sort((a, b) {
          try {
            return b.createdAt.compareTo(a.createdAt);
          } catch (e) {
            return 0;
          }
        });

        // 初始化点赞状态和计数
        for (var work in _works) {
          _isLikedMap[work.postId] = false;
          _likeCountMap[work.postId] = work.likeCount;
        }
        _isLoading = false;
      });
    } catch (e) {
      print('加载作品失败: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  // 点赞/取消点赞
  Future<void> _handleLike(int postId) async {
    final isLiked = _isLikedMap[postId] ?? false;
    try {
      if (isLiked) {
        // 取消点赞
        await _apiService.unlikePost(postId);
        setState(() {
          _isLikedMap[postId] = false;
          _likeCountMap[postId] = (_likeCountMap[postId] ?? 0) - 1;
        });
      } else {
        // 点赞
        await _apiService.likePost(postId);
        setState(() {
          _isLikedMap[postId] = true;
          _likeCountMap[postId] = (_likeCountMap[postId] ?? 0) + 1;
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

  // 评论
  Future<void> _handleComment(int postId) async {
    final TextEditingController commentController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('发表评论'),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(hintText: '请输入评论内容'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(commentController.text),
            child: const Text('发送'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      try {
        await _apiService.commentPost(postId, result);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('评论成功')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('评论失败: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 50, left: 23, right: 23, child: UpEdge(title: ' ')),

          Positioned(
            top: 70,
            left: 20,
            right: 20,
            bottom: 30,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text('错误: $_error'))
                : _works.isEmpty
                ? Center(child: Text('暂无作品'))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._works.map((work) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildWorkCard(work),
                          );
                        }),
                      ],
                    ),
                  ),
          ),

          //下方状态栏
          Positioned(bottom: 0, left: 0, right: 0, child: ZhuyeLowEdge()),

          //发布按钮
          Positioned(
            bottom: 22,
            left: MediaQuery.of(context).size.width / 2 - 105 / 2,
            child: Post(),
          ),
        ],
      ),
    );
  }

  // 构建作品卡片
  Widget _buildWorkCard(WorkItem work) {
    final isLiked = _isLikedMap[work.postId] ?? false;
    final likeCount = _likeCountMap[work.postId] ?? work.likeCount;
    final avatarUrl = work.avatarUrl ?? 'https://via.placeholder.com/100';
    final nickname = work.nickname ?? '未知用户';
    final hasImage = work.images != null && work.images.isNotEmpty;
    final firstImageUrl = hasImage
        ? work.images[0]
        : 'https://via.placeholder.com/240x180';

    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: primary2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部用户信息
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        width: 32,
                        height: 32,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 20,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    nickname, //昵称
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.grey,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 作品图片
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                //大容器300，左右30
                width: 240,
                height: 180, //3:4
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Image.network(
                  firstImageUrl, //只展示第一张图片
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            // 底部信息
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15,
              ),
              child: Row(
                children: [
                  // 评论按钮
                  GestureDetector(
                    onTap: () => _handleComment(work.postId),
                    child: Icon(Icons.edit, color: Colors.black, size: 16),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    //评论输入框
                    width: 180,
                    height: 30,
                    child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '添加评论...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 1, //降低输入框高度
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _handleComment(work.postId);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  // 点赞按钮
                  GestureDetector(
                    onTap: () => _handleLike(work.postId),
                    child: Row(
                      children: [
                        Icon(
                          isLiked
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          color: isLiked ? Colors.red : Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          likeCount.toString(),
                          style: TextStyle(
                            color: isLiked ? Colors.red : Colors.black,
                            fontSize: 14,
                            shadows: [
                              Shadow(
                                blurRadius: 2.0,
                                color: Colors.grey,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
