//选择新建还是草稿箱
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/page/zhuye.dart';
import 'package:we_pai/ui/page/new.dart';
import 'package:we_pai/ui/page/drafts.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:AppBar(
        automaticallyImplyLeading: false,
      ),
      
      
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          //返回按钮
          Positioned(
            top: 85,
            left: 9,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Zhuye()),
                );
              },
              child: Image.asset(
                'lib/material/return.png',
                width: 30,
                height: 30,
              ),
            ),
          ),

          //新建
          Positioned(
            top:291,
            left:25,
            child: CustomButton(
              text: '新建',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Newdraft()),
                );
              },
            ),
          ),

          //草稿箱
          Positioned(
            top:439,
            left:25,
            child: CustomButton(
              text: '草稿箱',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DisplayDrafts()),
                );
              },
            ),
          )
          
        ],
      ),
    );
  }
}
