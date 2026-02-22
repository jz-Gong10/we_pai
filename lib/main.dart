import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/page/zhuye.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'net/http.dart';
import 'package:we_pai/ui/widget/progress_indicator.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
    //return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background.png'),

          //We拍图片
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

          //登录按钮
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

              //暂时用这个直接跳转
              onPressed: () {
                navigate(context, Zhuye());
                printToast("登录成功");
              },

              //别删这段代码！！！千万别删，这是登录按钮的网络请求代码，但虚拟机不能访问，不便于调试就先注释掉了
              // onPressed: () async {
              //   setState(() {
              //     _loading = true;
              //   });
              //   try {
              //     final response = await Http().get(
              //       path:
              //           'http://127.0.0.1:4523/m1/7790878-7537573-default/login',
              //     );
              //     if (!mounted) return;
              //     if (response.statusCode == 200) {
              //       navigate(context, Zhuye());
              // Fluttertoast.showToast(
              //   msg: "登录成功",
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              //   backgroundColor: Colors.black54,
              //   textColor: Colors.white,
              // );
              //     } else {
              //       debugPrint("请求失败: \\${response.statusCode}");
              //     }
              //   } finally {
              //     if (mounted) {
              //       setState(() {
              //         _loading = false;
              //       });
              //     }
              //   }
              // },
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

          //加载中图标
          if (_loading)
            Positioned.fill(
              child: Container(
                color: Color.fromARGB(0, 0, 0, 0),
                child: const Center(child: CircularProgress()),
              ),
            ),
        ],
      ),
    );
  }
}
