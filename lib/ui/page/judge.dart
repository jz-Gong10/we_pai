import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/button.dart';

class Judge extends StatefulWidget {
  const Judge({super.key});

  @override
  State<Judge> createState() => _JudgeState();
}

class _JudgeState extends State<Judge> {
  // 评分状态
  int _qualityRating = 0;
  int _punctualityRating = 0;
  int _communicationRating = 0;

  // 处理星级评分
  void _handleRatingChange(String category, int rating) {
    setState(() {
      switch (category) {
        case 'quality':
          _qualityRating = rating;
          break;
        case 'punctuality':
          _punctualityRating = rating;
          break;
        case 'communication':
          _communicationRating = rating;
          break;
      }
    });
  }

  // 显示提交成功图片
  void _showSubmitSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Image.asset(
            'lib/material/submitok.png',
            width: 200,
            height: 200,
          ),
        );
      },
    );

    // 2秒后自动关闭
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  // 提交评价
  void _submitRating() {
    // 构建评分数据
    Map<String, int> ratings = {
      '摄影师拍摄质量': _qualityRating,
      '摄影师准时性': _punctualityRating,
      '沟通效率': _communicationRating,
    };

    print('提交的评分: $ratings');
    
    // 显示提交成功图片
    _showSubmitSuccess();
  }

  // 星级评分组件
  Widget _buildStarRating(String category, int currentRating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return GestureDetector(
          onTap: () => _handleRatingChange(category, starIndex),
          child: Icon(
            starIndex <= currentRating ? Icons.star : Icons.star_border,//当前星星编号小于等于当前评分就是实心的
            color: starIndex <= currentRating ? Colors.black : Colors.grey,
            size: 30,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 20, left: 23, right: 23, child: UpEdge(title: '评价')),

          Center(//页面居中
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text('请评价本单摄影师', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black)),
                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('摄影师拍摄质量:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black)),
                    SizedBox(height: 10),
                    _buildStarRating('quality', _qualityRating),
                
                    SizedBox(height: 20),
                    Text('摄影师准时性:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black)),
                    SizedBox(height: 10),
                    _buildStarRating('punctuality', _punctualityRating),
                
                    SizedBox(height: 20),
                    Text('沟通效率:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black)),
                    SizedBox(height: 10),
                    _buildStarRating('communication', _communicationRating),
                  ],
                ),
                
                SizedBox(height: 20),
                SubmitButton(
                  onPressed: _submitRating,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}