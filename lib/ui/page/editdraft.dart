//选中要编辑的草稿后进入这个页面，显示草稿内容
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';

class Editdraft extends StatefulWidget {
  const Editdraft({super.key});

  @override
  State<Editdraft> createState() => _EditdraftState();
}

class _EditdraftState extends State<Editdraft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Background(imagePath: 'lib/material/background2.png')],
      ),
    );
  }
}
