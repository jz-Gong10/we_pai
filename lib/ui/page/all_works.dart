import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/work.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/model/work_model.dart';

class MyWorks extends StatefulWidget {
  const MyWorks({super.key});

  @override
  State<MyWorks> createState() => _MyWorksState();
}

class _MyWorksState extends State<MyWorks> {
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
                                type: 'all',
                                avatarUrl: work.avatarUrl,
                                nickname: work.nickname,
                                description: work.content,
                                imageUrls: work.images,
                                likes: work.likeCount,
                                comments: _commentCounts[work.postId] ?? 0,
                                gradient: lhGradient,

                                onLike: () {
                                  print('Liked work ${work.postId}');
                                },
                                onComment: () {
                                  print('Commented on work ${work.postId}');
                                },
                                onDelete: () {
                                  print('Deleted work ${work.postId}');
                                },
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}