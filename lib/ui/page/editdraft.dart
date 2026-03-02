//编辑旧草稿页面
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';

class Editdraft extends StatefulWidget {
  const Editdraft({super.key});

  @override
  State<Editdraft> createState() => _EditdraftState();
}

class _EditdraftState extends State<Editdraft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),

      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          // 返回按钮
          Positioned(
            top: 15,
            left: 9,
            child: AppBackButton(),
          ),
          
          ],
      ),
    );
  }
}