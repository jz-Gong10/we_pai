//作品展示，目前做成了最新发布的展示在最上面，用摄影实践圈的数据，图片只展示第一张，砍掉了描述文本
import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/zhuye_low_edge.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/post.dart';

class WorkDisplay extends StatefulWidget {
  const WorkDisplay({super.key});

  @override
  State<WorkDisplay> createState() => _WorkDisplayState();
}

class _WorkDisplayState extends State<WorkDisplay> {
  // 模拟数据
  final List<Map<String, dynamic>> works = [
    {
      'avatarUrl': 'https://via.placeholder.com/48',
      'nickname': '叮咚鸡',
      'description': '一看就会的九种万能摄影构图公式！',
      'imageUrls': List.generate(9, (index) => 'https://via.placeholder.com/100'),
      'likes': 1111,
      'comments': 2222,
      'createdAt': DateTime.now().subtract(Duration(hours: 1)),
    },
    {
      'avatarUrl': 'https://via.placeholder.com/48',
      'nickname': '叮咚鸡',
      'description': '今年涨幅最多的光影街拍合集（附拍摄技巧）',
      'imageUrls': List.generate(9, (index) => 'https://via.placeholder.com/100'),
      'likes': 1111,
      'comments': 2222,
      'createdAt': DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      'avatarUrl': 'https://via.placeholder.com/48',
      'nickname': '叮咚鸡',
      'description': '原来这就是摄影眼！如何发现角落里的美',
      'imageUrls': List.generate(3, (index) => 'https://via.placeholder.com/100'),
      'likes': 1111,
      'comments': 2222,
      'createdAt': DateTime.now().subtract(Duration(hours: 3)),
    },
  ];

  // 按时间排序，最新的在前
  List<Map<String, dynamic>> get _sortedWorks {
    return List.from(works)..sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 20, left: 23, right: 23, child: UpEdge(title: ' ')),

          Positioned(
            top: 70,
            left: 20,
            right: 20,
            bottom: 30, 
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._sortedWorks.map((work) {
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
  Widget _buildWorkCard(Map<String, dynamic> work) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: primary2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
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
                      image: DecorationImage(
                        image: NetworkImage(work['avatarUrl']),//头像
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    work['nickname'],//昵称
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
              child: Container(//大容器300，左右30
                width: 240,
                height: 180,//3:4
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Image.network(
                  work['imageUrls'][0],//只展示第一张图片
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 底部信息
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical:15),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(//评论输入框
                    width: 180,
                    height: 30,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '添加评论...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 1,//降低输入框高度
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Colors.black,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        work['likes'].toString(),
                        style: TextStyle(
                          color: Colors.black,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}