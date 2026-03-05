import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/user_show.dart';
import 'package:we_pai/ui/page/my_works.dart';
import 'package:we_pai/ui/page/judge.dart';

class Wode extends StatefulWidget {
  const Wode({super.key});

  @override
  State<Wode> createState() => _WodeState();
}

class _WodeState extends State<Wode> {
  final ApiService _apiService = ApiService();
  String? _error;
  String name = '未知用户';
  String casId = '000000';
  String avatarUrl = '';
  int role = 2; // 用户角色：1=普通用户，2=摄影师

  // 展开/收起状态
  bool _isReservationExpanded = false; // 预约单展开状态
  bool _isOrderExpanded = false; // 客单展开状态

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _error = null;
    });
    try {
      // 并发请求示例
      var userInfo = await _apiService.getUserInfo();

      setState(() {
        name = userInfo.name;
        casId = userInfo.casId;
        avatarUrl = userInfo.avatarUrl;
        role = userInfo.role;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
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

          Positioned(
            top: 30,
            left: 23,
            right: 23,
            child: UpEdge(title: '个人主页'),
          ),

          Positioned(
            top: 90,
            left: 25,
            right: 25,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 用户信息
                  UserShow(
                    change: true, // 我自己的主页我当然可以改啦
                    name: name,
                    casId: casId,
                    avatarUrl: avatarUrl ?? '',
                  ),
                  SizedBox(height: 20),

                  // 我的预约单板块（所有角色都显示）
                  Container(
                    width: contentWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: pinkGradient,
                      border: Border.all(color: primary3, width: 1),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isReservationExpanded = !_isReservationExpanded;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '我的预约单',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  _isReservationExpanded
                                      ? Icons.arrow_circle_up
                                      : Icons.arrow_circle_down,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 展开内容
                        if (_isReservationExpanded)
                          Column(
                            children: [
                              Divider(height: 1, color: primary3),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: [
                                    // 预约单项目
                                    _buildReservationItem(
                                      '毕业季帮拍，需自带设备。',
                                      '对接中',
                                    ),
                                    Divider(height: 1, color: primary3),
                                    _buildReservationItem(
                                      '个人写真，需自带设备。',
                                      '已完成',
                                      showEvaluate: true,
                                    ),
                                    Divider(height: 1, color: primary3),
                                    _buildReservationItem('风景，需自带设备。', '待接单'),
                                    Divider(height: 1, color: primary3),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  // role=2：显示我的约拍客单和展开内容
                  if (role == 2) ...[
                    SizedBox(height: 20),
                    Container(
                      width: contentWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: pinkGradient,
                        border: Border.all(color: primary3, width: 1),
                      ),
                      child: Column(
                        children: [
                          // 标题栏
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isOrderExpanded = !_isOrderExpanded;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '我的约拍客单（客单管理）',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    _isOrderExpanded
                                        ? Icons.arrow_circle_up
                                        : Icons.arrow_circle_down,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 展开内容
                          if (_isOrderExpanded)
                            Column(
                              children: [
                                Divider(height: 1, color: primary3),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      // 客单项目
                                      _buildOrderItem('毕业季帮拍，需自带设备。', '对接中'),
                                      Divider(height: 1, color: primary3),
                                      _buildOrderItem('毕业季帮拍，需自带设备。', '已完成'),
                                      Divider(height: 1, color: primary3),
                                      _buildOrderItem('毕业季帮拍，需自带设备。', '已完成'),
                                      Divider(height: 1, color: primary3),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],

                  // role=2：显示我的作品
                  if (role == 2) ...[
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyWorks()),
                        );
                      },
                      child: Container(
                        width: contentWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: pinkGradient,
                          border: Border.all(color: primary3, width: 1),
                        ),
                        child: Text(
                          '我的作品',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建预约单项目
  Widget _buildReservationItem(
    String description,
    String status, {
    bool showEvaluate = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text('预算')]),
          SizedBox(height: 8),

          Text(description),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Text(status),
              ),
              if (showEvaluate)
                Row(
                  children: [
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Judge(),
                          ), //点击跳转到评价页面
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Text('去评价'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  // 客单
  Widget _buildOrderItem(String description, String status) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 第一行：预算在右上角
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text('预算')]),
          SizedBox(height: 8),

          Row(
            children: [
              // 头像展示的小方框（这里先做成了默认头像）
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: qianhui,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.person, size: 20, color: Colors.grey),
              ),
              SizedBox(width: 8),
              Text('叮咚鸡'),
            ],
          ),

          // 描述
          SizedBox(height: 8),
          Text(description),
          SizedBox(height: 10),

          // 状态按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Text(status),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
