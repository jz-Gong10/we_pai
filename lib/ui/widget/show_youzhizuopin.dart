import 'package:flutter/material.dart';

class ShowYouzhizuopin extends StatefulWidget {
  final String imageURL;
  const ShowYouzhizuopin({super.key, required this.imageURL});

  @override
  State<ShowYouzhizuopin> createState() => _ShowYouzhizuopinState();
}

class _ShowYouzhizuopinState extends State<ShowYouzhizuopin> {
  @override
  Widget build(BuildContext context) {
    bool isError = widget.imageURL == '获取公告失败';
    
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isError 
            ? const Color.fromARGB(255, 201, 201, 201)  // 搜索栏的颜色（不透明度100%）
            : Colors.grey,  // 原来的背景色
      ),
      child: widget.imageURL.startsWith('http')
          ? Image.network(
              widget.imageURL,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text(widget.imageURL));
              },
            )
          : Center(
              child: Text(
                widget.imageURL,
                style: TextStyle(
                  color: isError 
                      ? const Color.fromARGB(255, 50, 50, 50)  // 错误时使用深色字体
                      : Colors.white,  // 正常时使用白色
                  fontSize: 16,
                ),
              ),
            ),
    );
  }
}
