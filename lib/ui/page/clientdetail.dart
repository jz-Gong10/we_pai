//用户详情页，下面的作品展示我选择直接搬my_works
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/user_show.dart';
import 'package:we_pai/ui/widget/work.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/module/recieve_zishenxinxi.dart';
import 'package:we_pai/model/work_model.dart';

class Clientdetail extends StatefulWidget {
  const Clientdetail({super.key});

  @override
  State<Clientdetail> createState() => _ClientdetailState();
}

class _ClientdetailState extends State<Clientdetail> {
  final ApiService _apiService = ApiService();
  UserInfo? _userInfo;
  List<WorkItem> _works = [];
  bool _isLoading = true;
  String? _error;
  bool _isFollowing = false;
  int _followers = 0;

  // 格式化数字，超过10000显示为x.xw
  String formatNumber(int number) {
    if (number >= 10000) {
      return '${(number / 10000).toStringAsFixed(1)}w';// .toStringAsFixed(1)：将结果格式化为保留一位小数的字符串
    }
    return number.toString();
  }

  // 关注/取消关注逻辑
  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;// 倒反天罡
      if (_isFollowing) {
        _followers += 1;
      } else {
        _followers -= 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final userInfo = await _apiService.getUserInfo();
      final worksResponse = await _apiService.getMyWorks(1, 10);
      setState(() {
        _userInfo = userInfo;
        _works = worksResponse.data.list;
        _followers = 11000; // 临时值，实际应该从API获取
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
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth - 40;

    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 20, left: 23, right: 23, child: UpEdge(title: '用户详情页')),

          Positioned(
            top: 100,
            left: 20,
            right: 20,
            bottom: 0,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text('错误: $_error'))
                    : _userInfo != null
                        ? SingleChildScrollView(
                            child: Container(
                              width: contentWidth,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // UserShow组件：头像，昵称，id
                                  UserShow(
                                    name: _userInfo!.nickname,
                                    casId: 'id : ${_userInfo!.casId}',
                                    avatarUrl: _userInfo!.avatarUrl,
                                    change: false,
                                  ),
                                  SizedBox(height: 20),

                                  // 获赞量、粉丝、接单量
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      // 获赞量
                                      Column(
                                        children: [
                                          Text(
                                            formatNumber(_userInfo!.totalLikes),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('获赞量'),
                                        ],
                                      ),

                                      // 粉丝
                                      Column(
                                        children: [
                                          Text(
                                            formatNumber(_followers),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('粉丝'),
                                        ],
                                      ),

                                      // 接单量
                                      Column(
                                        children: [
                                          Text(
                                            formatNumber(_userInfo!.totalOrders),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('接单量'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),

                                  // 关注按钮
                                  GestureDetector(
                                    onTap: _toggleFollow,
                                    child: Container(
                                      width: contentWidth,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: pinkGradient,
                                        border: Border.all(color: primary3, width: 1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _isFollowing ? '已关注' : '关注',// 关注了就显示已关注
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  // 显示作品列表
                                  _works.isEmpty
                                      ? Text('暂无作品')
                                      : Column(
                                          children: _works.map((work) {
                                            return Work(
                                              postId: work.postId,
                                              avatarUrl: work.avatarUrl,
                                              nickname: work.nickname,
                                              description: work.content,
                                              imageUrls: work.images,
                                              likes: work.likeCount,
                                              comments: work.commentCount,
                                              isLiked: false,
                                              type: 'my',//我的作品
                                              gradient: pinkGradient,
                                              onRefresh: _loadData,
                                            );
                                          }).toList(),
                                        ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
                        : Center(child: Text('暂无数据')),
          ),
        ],
      ),
    );
  }
}
