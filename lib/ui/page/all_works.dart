//摄影实践圈
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/work.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/model/work_model.dart';

class AllWorks extends StatefulWidget {
  const AllWorks({super.key});

  @override
  State<AllWorks> createState() => _AllWorksState();
}

class _AllWorksState extends State<AllWorks> {
  final ApiService _apiService = ApiService();
  List<WorkItem> _works = [];
  Map<int, int> _commentCounts = {};
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
      setState(() {
        _works = response.data.list;
        _isLoading = false;
      });
      _loadCommentCounts();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCommentCounts() async {
    for (var work in _works) {
      try {
        final commentResponse = await _apiService.getComments(work.postId);
        setState(() {
          _commentCounts[work.postId] = commentResponse.data.list.length;
        });
      } catch (e) {
        setState(() {
          _commentCounts[work.postId] = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: '摄影实践圈')),

          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text('错误: $_error'))
                    : _works.isEmpty
                        ? Center(child: Text('暂无作品'))
                        : ListView.builder(
                            itemCount: _works.length,
                            itemBuilder: (context, index) {
                              final work = _works[index];
                              
                              return Work(
                                //每个作品用work.dart中的Work组件显示
                                postId: work.postId,
                                type: 'all',
                                //这里设置种类为all，没有删除，展示所有人的作品
                                avatarUrl: work.avatarUrl,
                                nickname: work.nickname,
                                description: work.content,
                                imageUrls: work.images,
                                likes: work.likeCount,
                                comments: _commentCounts[work.postId] ?? 0,
                                //接口那里没看到有直接获得评论数，_commentCounts这里用的获取评论接口，获取list长度
                                isLiked: false, // 列表接口暂未返回isLiked字段，默认为false
                                gradient: lhGradient,
                                onRefresh: _loadWorks,
                              );

                            },
                          ),
          ),
        ],
      ),
    );
  }
}