import 'package:flutter/material.dart';

class SYSShowBlock extends StatefulWidget {
  final String nickname;
  final String casId;
  final String avatarUrl;
  final int orderCount;
  final List<String> style;
  final List<String> type;
  final List<String> equipment;

  const SYSShowBlock({
    super.key,
    required this.nickname,
    required this.avatarUrl,
    required this.orderCount,
    required this.casId,
    required this.style,
    required this.type,
    required this.equipment,
  });

  @override
  State<SYSShowBlock> createState() => _SYSShowBlockState();
}

class _SYSShowBlockState extends State<SYSShowBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 274,
      padding: EdgeInsets.all(16), // 添加内边距
      color: Color.fromARGB(175, 169, 236, 204),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 头像
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(11),
                child: (widget.avatarUrl != null && widget.avatarUrl.isNotEmpty)
                    ? Image.network(
                        widget.avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // 图片加载失败时显示默认头像
                          return Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.grey,
                          );
                        },
                      )
                    : Icon(
                        Icons.person,
                        size: 24,
                        color: Colors.grey,
                      ), // 无URL时显示默认头像
              ),

              // 昵称和ID
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nickname,
                    style: TextStyle(
                      fontSize: 16, // 稍微调小字号
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.casId,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),

              Spacer(), // 添加弹性空间
              // 接单量
              Text('${widget.orderCount}\n接单量'),
            ],
          ),

          SizedBox(height: 16), // 添加间距

          Text('设备：${widget.equipment}'),

          Text('风格：${widget.style}'),

          SizedBox(height: 8),

          Text('类型：${widget.type}'),
        ],
      ),
    );
  }
}
