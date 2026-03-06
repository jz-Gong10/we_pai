import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/widget/show_youzhizuopin.dart';
import 'package:we_pai/module/recieve_kedan.dart';

class KedanguangchangPage extends StatefulWidget {
  const KedanguangchangPage({super.key});

  @override
  State<KedanguangchangPage> createState() => _KedanguangchangState();
}

class _KedanguangchangState extends State<KedanguangchangPage> {
  final ApiService apiService = ApiService();
  List<String> announcement = ['暂无公告'];
  List<KedanOrder> kedanList = [];

  @override
  void initState() {
    super.initState();
    _kedan();
  }

  Future<void> _kedan() async {
    try {
      List<KedanOrder> _kedanList = await apiService.getKedan();
      setState(() {
        if (_kedanList.isNotEmpty) {
          kedanList = _kedanList;
        }
      });
    } catch (e) {
      setState(() {
        kedanList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(
            top: 65,
            left: 23,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 16),

          // 搜索框
          Positioned(left: 42, top: 104, child: Search()),

          // 公告列表
          Positioned(
            left: 27,
            top: 172,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 306),
              child: ShowYouzhizuopin(),
            ),
          ),

          Positioned(
            left: 353,
            top: 172,
            child:
                // 我的预约按钮
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        '我的预约',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
          ),
          const SizedBox(height: 20),

          Positioned(
            left: 59,
            top: 391,
            child: Container(
              width: 306,
              height: 400,
              child:
                  // 任务卡片列表
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: kedanList.isEmpty
                        ? [const Center(child: Text('暂无订单'))]
                        : kedanList
                              .map(
                                (order) => Column(
                                  children: [
                                    _buildTaskCard(
                                      category: order.type ?? '未知类型',
                                      salary:
                                          '${order.price ?? 0}r/${order.duration ?? '未知'}',
                                      needEquipment:
                                          order.needEquipment ?? false,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              )
                              .toList(),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String? category,
    required String salary,
    required bool? needEquipment,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '分类: ${category ?? '未知类型'}',
              style: const TextStyle(color: Colors.orange, fontSize: 16),
            ),
            Text(
              '薪酬: $salary',
              style: const TextStyle(color: Colors.orange, fontSize: 16),
            ),
            Text(
              '是否需要专业设备: ${needEquipment ?? false ? '是' : '否'}',
              style: const TextStyle(color: Colors.orange, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('待接单'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('接单'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
