//入驻成功后跳转到这个页面
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/page/wanshanziliao.dart';

class Ruzhuok extends StatelessWidget {
  const Ruzhuok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: '入驻！')),

           Align(
            alignment: Alignment.centerLeft, 
            child: Padding(
              padding: EdgeInsets.only(top: 50), 
              child: Container(
                width: 280,
                height: 210,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/material/smile2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 40, 
            left: 23, 
            right: 23, 
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(264, 60),
                backgroundColor: Color(0xFFFCCEB4),
                foregroundColor: Color(0xffF9F2EF),
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                shadowColor: Color(0x80F98C53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                '完善资料',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  color: Color(0xffF9F2EF),
                  shadows: [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Wanshanziliao(userType: 'photographer'),//跳转到完善资料（摄影师）喵
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}