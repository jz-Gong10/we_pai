import 'package:flutter/material.dart';

class SYSShowBlock extends StatefulWidget {
  final String nickname;
  final String casId;
  final String avatarUrl;
  final int orderCount;
  final String style;
  final String type;

  const SYSShowBlock({
    super.key,
    required this.nickname,
    required this.avatarUrl,
    required this.orderCount,
    required this.casId,
    required this.style,
    required this.type,
  });

  @override
  State<SYSShowBlock> createState() => _SYSShowBlockState();
}

class _SYSShowBlockState extends State<SYSShowBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 356,
      height: 274,
      color: Color.fromARGB(175, 169, 236, 204),
      child: Column(
        children: [
          SizedBox(
            width: 135,
            height: 44,
            child: Row(
              children: [
                Container(
                  color: Colors.grey,
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(11),
                  child: Image.network(widget.avatarUrl ?? ''),
                ),

                Column(
                  children: [
                    Text(
                      widget.nickname,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.casId,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),

                Text('${widget.orderCount}\n接单量'),
              ],
            ),
          ),

          Text('风格：\n${widget.style}'),

          Text('类型：\n${widget.type}'),
        ],
      ),
    );
  }
}
