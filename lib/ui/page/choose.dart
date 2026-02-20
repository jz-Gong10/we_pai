//选择新建还是草稿箱
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';

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
        automaticallyImplyLeading: true,//返回按钮
      ),
      
      
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                //新建按钮
                CustomButton(text: '新建', onPressed: () {}),
            
                SizedBox(height: 30), 
            
                //草稿箱按钮
                CustomButton(text: '草稿箱', onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
