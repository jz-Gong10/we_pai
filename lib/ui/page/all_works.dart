import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/work.dart';
import 'package:we_pai/ui/themes/colors.dart';

class MyWorks extends StatefulWidget {
  const MyWorks({super.key});

  @override
  State<MyWorks> createState() => _MyWorksState();
}

class _MyWorksState extends State<MyWorks> {
  // 模拟数据
  final List<Map<String, dynamic>> works = [
    {
      'avatarUrl': 'https://via.placeholder.com/48',
      'nickname': '叮咚鸡',
      'description': '一看就会的九种万能摄影构图公式！',
      'imageUrls': List.generate(9, (index) => 'https://via.placeholder.com/100'),
      'likes': 1111,
      'comments': 2222,
    },
    {
      'avatarUrl': 'https://via.placeholder.com/48',
      'nickname': '叮咚鸡',
      'description': '今年涨幅最多的光影街拍合集（附拍摄技巧）',
      'imageUrls': List.generate(9, (index) => 'https://via.placeholder.com/100'),
      'likes': 1111,
      'comments': 2222,
    },
    {
      'avatarUrl': 'https://via.placeholder.com/48',
      'nickname': '叮咚鸡',
      'description': '原来这就是摄影眼！如何发现角落里的美',
      'imageUrls': List.generate(3, (index) => 'https://via.placeholder.com/100'),
      'likes': 1111,
      'comments': 2222,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: '摄影实践圈')),

          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: ListView.builder(
              itemCount: works.length,
              itemBuilder: (context, index) {
                final work = works[index];
                return Work(
                  type: 'all',
                  avatarUrl: work['avatarUrl'],
                  nickname: work['nickname'],
                  description: work['description'],
                  imageUrls: List<String>.from(work['imageUrls']),
                  likes: work['likes'],
                  comments: work['comments'],
                  gradient: lhGradient,

                  onLike: () {
                    // 点赞逻辑
                    print('Liked work $index');
                  },
                  onComment: () {
                    // 评论逻辑
                    print('Commented on work $index');
                  },
                  onDelete: () {
                    // 删除逻辑
                    print('Deleted work $index');
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