//我的预约单
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/service/api_service.dart';

class Yuyuedan extends StatefulWidget {
  const Yuyuedan({super.key});

  @override
  State<Yuyuedan> createState() => _YuyuedanState();
}

class _YuyuedanState extends State<Yuyuedan> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> orderList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  // 从接口获取预约单列表
  Future<void> _loadOrders() async {
    try {
      // TODO: 替换为真实API调用
      // final response = await apiService.getMyOrders(pageNum: 1, pageSize: 10);
      // setState(() {
      //   orderList = response;
      //   isLoading = false;
      // });

      // 模拟数据
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        orderList = [
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '用户1',
            'budget': '100-200',
            'description': '毕业季帮拍，需自带设备。',
            'status': '对接中',
          },
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '用户2',
            'budget': '200-300',
            'description': '毕业季帮拍，需自带设备。',
            'status': '已完成',
          },
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '用户3',
            'budget': '150-250',
            'description': '毕业季帮拍，需自带设备。',
            'status': '待接单',
          },
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '用户4',
            'budget': '100-200',
            'description': '毕业季帮拍，需自带设备。',
            'status': '对接中',
          },
          {
            'avatarUrl': 'https://via.placeholder.com/48',
            'nickname': '用户5',
            'budget': '300-400',
            'description': '毕业季帮拍，需自带设备。',
            'status': '对接中',
          },
        ];
        isLoading = false;
      });
    } catch (e) {
      print('获取预约单列表失败: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 20, left: 23, right: 23, child: UpEdge(title: '我的预约单')),

          // 预约单列表
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : orderList.isEmpty
                    ? const Center(child: Text('暂无预约单'))
                    : ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          final order = orderList[index];
                          return _buildOrderCard(order);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: primary1,
        borderRadius: BorderRadius.circular(15),
        //边框阴影
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4, //模糊半径
              offset: Offset(0, 4), //偏移量(x, y)，向下偏移产生投影
            ),
          ],
        border: Border.all(color: primary3, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像、昵称、预算
          Row(
            children: [
              // 方形头像
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(order['avatarUrl'] ?? 'https://via.placeholder.com/48'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 昵称
              Text(
                order['nickname'] ?? '用户',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // 预算
              Text(
                '预算: ${order['budget'] ?? '0'}',
                style: TextStyle(
                  fontSize: 14,
                  color: primary3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 描述文本
          Text(
            order['description'] ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // 状态按钮
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(order['status']),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order['status'] ?? '待接单',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case '对接中':
        return Colors.orange;
      case '已完成':
        return Colors.green;
      case '待接单':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
