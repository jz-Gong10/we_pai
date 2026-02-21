import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/page/zhuye.dart';

import 'package:we_pai/ui/page/choose.dart';
//测试
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Choose());
    //return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background.png'),

          Positioned(
            top: 237,
            left: 60,
            child: Container(
              alignment: Alignment.center,
              width: 319,
              height: 365,
              margin: const EdgeInsets.only(bottom: 100),
              child: Image.asset(
                'lib/material/1120fa15bec5da27842e7e3a2df7ff7754644030.png',
                fit: BoxFit.fill,
              ),
            ),
          ),

          Positioned(
            top: 762,
            left: 88,
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
              onPressed: () => navigate(context, Zhuye()),
              child: Text(
                '登录',
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
            ),
          ),
        ],
      ),
    );
  }
}
