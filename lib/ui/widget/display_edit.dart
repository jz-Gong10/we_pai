//选择草稿编辑的框框，包括时间，编辑按钮（没写完）
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/themes/colors.dart';

class DisplayEdit extends StatefulWidget {
  const DisplayEdit({super.key});

  @override
  State<DisplayEdit> createState() => _DisplayEditState();
}

class _DisplayEditState extends State<DisplayEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: primary1, 
        border: Border.all(color: primary2), 
        borderRadius: BorderRadius.circular(12), 
      )
    );
  }
}