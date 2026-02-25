//选择新建还是草稿箱
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/page/new.dart';
import 'package:we_pai/ui/page/drafts.dart';
import 'package:we_pai/ui/widget/up_edge.dart';

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

          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: ' ')),

          // 居中显示的按钮
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //新建
                CustomButton(
                  text: '新建',
                  width: MediaQuery.of(context).size.width - 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Newdraft()),
                    );
                  },
                ),
                const SizedBox(height: 50), // 按钮间距
                //草稿箱
                CustomButton(
                  text: '草稿箱',
                  width: MediaQuery.of(context).size.width - 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DisplayDrafts()),
                    );
                  },
                ),
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
