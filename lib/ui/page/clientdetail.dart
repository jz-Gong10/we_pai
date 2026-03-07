//用户详情页，下面的作品展示我选择直接搬my_works
import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/module/user_detail_model.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/user_show.dart';
import 'package:we_pai/ui/widget/work.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/themes/colors.dart';

class Clientdetail extends StatefulWidget {
  final String casId;
  const Clientdetail({super.key, required this.casId});

  @override
  State<Clientdetail> createState() => _ClientdetailState();
}

class _ClientdetailState extends State<Clientdetail> {
  final ApiService _apiService = ApiService();
  bool _isFollowing = false;
  int _likes = 111000;
  int _followers = 11000;
  int _orders = 11;
  String _name = '叮咚鸡';
  String _avatarUrl = '';
  String _error = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserDetail();
  }

  Future<void> _loadUserDetail() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      var response = await _apiService.getUserDetail(widget.casId);
      if (response.data != null) {
        setState(() {
          _name = response.data!.nickname ?? '未知用户';
          _avatarUrl = response.data!.avatarUrl ?? '';
          _likes = response.data!.totalLikes ?? 0;
          _orders = response.data!.totalOrders ?? 0;
        });
      }
    } catch (e) {
      setState(() {
        _error = '加载用户详情失败: $e';
      });
      print('加载用户详情失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 格式化数字，超过10000显示为x.xw
  String formatNumber(int number) {
    if (number >= 10000) {
      return '${(number / 10000).toStringAsFixed(1)}w'; // .toStringAsFixed(1)：将结果格式化为保留一位小数的字符串
    }
    return number.toString();
  }

  // 关注/取消关注逻辑
  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing; // 倒反天罡
      if (_isFollowing) {
        _followers += 1;
      } else {
        _followers -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth - 40;

    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(
            top: 20,
            left: 23,
            right: 23,
            child: UpEdge(title: '用户详情页'),
          ),

          Positioned(
            top: 100,
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                width: contentWidth,
                alignment: Alignment.center,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // UserShow组件：头像，昵称，id
                    _isLoading
                        ? CircularProgressIndicator()
                        : _error.isNotEmpty
                        ? Text(_error, style: TextStyle(color: Colors.red))
                        : UserShow(
                            name: _name,
                            casId: 'id : ${widget.casId}',
                            avatarUrl: _avatarUrl,
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
                              formatNumber(_likes),
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
                              formatNumber(_orders),
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
                          _isFollowing ? '已关注' : '关注', // 关注了就显示已关注
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // 显示作品
                    Work(
                      postId: 111,
                      avatarUrl: _avatarUrl,
                      nickname: _name,
                      description: '一看就会的九种万能摄影构图公式！',
                      imageUrls: List.generate(9, (index) => ''),
                      likes: 1111,
                      comments: 2222,
                      type: 'sb',
                      gradient: pinkGradient,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
