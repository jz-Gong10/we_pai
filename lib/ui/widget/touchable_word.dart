import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/yijianfankui.dart';
import 'package:we_pai/ui/widget/background.dart';

class TouchableWord extends StatefulWidget {
  final String content;
  const TouchableWord({super.key, required this.content});

  @override
  State<TouchableWord> createState() => _TouchableWordState();
}

class _TouchableWordState extends State<TouchableWord> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        navigate(context, Yijianfankui());
      },
      child: Text(widget.content, style: TextStyle(color: Colors.grey)),
    );
  }
}
