//新建草稿页面
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/page/choose.dart';

class Newdraft extends StatefulWidget {
  const Newdraft({super.key});

  @override
  State<Newdraft> createState() => _NewdraftState();
}

class _NewdraftState extends State<Newdraft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  MaterialPageRoute(builder: (context) => const Choose()),
                );
              },
              child: Image.asset(
                'lib/material/return.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
          
          ],
      ),
    );
  }
}
