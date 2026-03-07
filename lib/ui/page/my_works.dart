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
      final response = await _apiService.getMyWorks(1, 10);
      setState(() {
        _works = response.data.list;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 40, left: 23, right: 23, child: UppEdge()),

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
                        postId: work.postId,
                        type: 'my',
                        avatarUrl: work.avatarUrl,
                        nickname: work.nickname,
                        description: work.content,
                        imageUrls: work.images,
                        likes: work.likeCount,
                        comments: work.commentCount,
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
