import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/widget/show_anoucement.dart';
import 'package:we_pai/module/recieve_kedan.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/page/my_yyd.dart';

class KedanguangchangPage extends StatefulWidget {
  const KedanguangchangPage({super.key});

  @override
  State<KedanguangchangPage> createState() => _KedanguangchangState();
}

class _KedanguangchangState extends State<KedanguangchangPage> {
  final ApiService apiService = ApiService();
  List<String> announcement = ['暂无公告'];
  List<Map<String, dynamic>> kedanList = [];
  List<bool> _taskStatus = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // 从接口获取任务列表
  Future<void> _loadTasks() async {
    try {
      List<Map<String, dynamic>> taskList = await apiService.getTaskList(pageNum: 1, pageSize: 10);
      setState(() {
        kedanList = taskList.map<Map<String, dynamic>>((task) {
          // 清理头像URL中的空格和反引号
          String avatarUrl = (task['customerAvatar'] ?? '').toString().trim();
          avatarUrl = avatarUrl.replaceAll('`', '').trim();
          
          return {
            'avatarUrl': avatarUrl.isNotEmpty ? avatarUrl : 'https://via.placeholder.com/48',
            'nickname': task['customerName'] ?? '用户',
            'type': task['type'] ?? '未知类型',
            'price': task['price'] ?? 0,
            'duration': task['duration'] ?? 'h',
            'needEquipment': task['needEquipment'] ?? false,
            'status': task['status'] == 0 ? '待接单' : '已接单',
            'orderId': task['orderId'],
          };
        }).toList();
        _taskStatus = kedanList.map((task) => task['status'] == '已接单').toList();
      });
    } catch (e) {
      print('获取任务列表失败: $e');
      // 使用模拟数据作为备用
      setState(() {
        kedanList = [
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '张三',
            'type': '毕业照约拍',
            'price': 50,
            'duration': 'h',
            'needEquipment': true,
            'status': '待接单',
            'orderId': 1,
          },
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '李四',
            'type': '小动物',
            'price': 60,
            'duration': 'h',
            'needEquipment': false,
            'status': '待接单',
            'orderId': 2,
          },
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '王五',
            'type': '风景',
            'price': 40,
            'duration': 'h',
            'needEquipment': true,
            'status': '待接单',
            'orderId': 3,
          },
        ];
        _taskStatus = kedanList.map((task) => task['status'] == '已接单').toList();
      });
    }
  }

  void _handleAcceptTask(int index) {
    setState(() {
      _taskStatus[index] = true;
    });
    _kedan();
  }

  Future<void> _kedan() async {
    try {
      List<KedanOrder> _kedanList = await apiService.getKedan();
      setState(() {
        if (_kedanList.isNotEmpty) {
          kedanList = _kedanList.map<Map<String, dynamic>>((order) => {
            'avatarUrl': order.customerAvatar,
            'nickname': order.customerName,
            'type': order.type,
            'price': order.price,
            'duration': order.duration,
            'needEquipment': order.needEquipment,
            'status': order.status == 0 ? '待接单' : '已接单',
            'orderId': order.orderId,
          }).toList();
          _taskStatus = kedanList.map((task) => task['status'] == '已接单').toList();
        }
      });
    } catch (e) {
      setState(() {
        kedanList = [];
        _taskStatus = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rowWidth = screenWidth * 0.8;
    double spacing = 10.0;
    double announcementWidth = (rowWidth - spacing) * 4/5;
    double orderWidth = (rowWidth - spacing) * 1/5;

    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 65),
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 16),

                // 搜索框
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // 左右各留10%的空间
                  child: Container(
                    width: rowWidth,
                    child: Search(),
                  ),
                ),
                const SizedBox(height: 40),

                // 公告和我的预约单
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // 左右各留10%的空间
                  child: Container(
                    width: rowWidth,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 公告列表
                        Container(
                          width: announcementWidth,
                          child: ShowAnouncement(),
                        ),
                        const SizedBox(width: 10),
                        // 我的预约单按钮
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Yuyuedan()),
                            );
                          },
                          child: Container(
                            width: orderWidth,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 201, 201, 201),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: Text('我\n的\n预\n约\n单\n', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 任务卡片列表
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    width: double.infinity,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: kedanList.isEmpty
                          ? [const Center(child: Text('暂无订单'))]
                          : List.generate(
                              kedanList.length,
                              (index) {
                                final order = kedanList[index];
                                return Column(
                                  children: [
                                    _buildTaskCard(
                                      avatarUrl: order['avatarUrl'],
                                      nickname: order['nickname'],
                                      
                                      index: index,
                                      category: order['type'] ?? '未知类型',
                                      salary:
                                          '${order['price'] ?? 0}r/${order['duration'] ?? '未知'}',
                                      needEquipment:
                                          order['needEquipment'] ?? false,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              },
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String avatarUrl,
    required String nickname,
    required String category,
    required String salary,
    required bool needEquipment,
    required int index,
  }) {
    bool isAccepted = _taskStatus[index];
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color:primary2,
        borderRadius: BorderRadius.circular(15),

        //边框阴影
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4, //模糊半径
              offset: Offset(0, 4), //偏移量(x, y)，向下偏移产生投影
            ),
          ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像和昵称
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
          const SizedBox(height: 16),
          // 任务信息
          Text(
            '分类: $category',
            style: TextStyle(
              color: primary3,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          Text(
            '薪酬: $salary',
            style: TextStyle(
              color: primary3,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          Text(
            '是否需要专业设备: ${needEquipment ? '是' : '否'}',
            style: TextStyle(
              color: primary3, 
              fontWeight: FontWeight.bold,
              fontSize: 16,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // 底部状态和按钮
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      isAccepted ? '已接单' : '待接单',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: const SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => !isAccepted ? _handleAcceptTask(index) : null,
                  child: Container(
                    height: 40,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        isAccepted ? '已接单' : '接单',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
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
