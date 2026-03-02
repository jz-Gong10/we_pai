import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_pai/service/dio_service.dart';
import 'package:we_pai/ui/page/array.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/page/zhuye.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'net/http.dart';
import 'package:we_pai/ui/widget/progress_indicator.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:we_pai/ui/page/my_works.dart';
import 'package:we_pai/ui/page/wode.dart';
import 'package:we_pai/ui/page/drafts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//测试
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: DisplayDrafts());
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bool _loading = false;

  final String url =
      'https://i.sdu.edu.cn/cas/proxy/login/page?forward=https%3a%2f%2fwww.h10eaea4e.nyat.app%3a48561%2flogin';

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw '无法打开该网址: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background.png'),

          //We拍图片
          Positioned(
            top: 150,
            left: 30,
            right: 30,
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
            top: 550,
            left: MediaQuery.of(context).size.width / 2 - 132,
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

              // 暂时用这个直接跳转
              onPressed: () {
                _launchURL();
                navigate(context, Zhuye());
                printToast("登录成功");
              },

              // 别删这段代码！！！千万别删，这是登录按钮的网络请求代码，但虚拟机不能访问，不便于调试就先注释掉了
              // onPressed: () async {
              //   setState(() {
              //     _loading = true;
              //   });
              //   try {
              //     final response = await Http().get(
              //       path: '/login',
              //       queryParameters: {
              //         'token':
              //             'eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJjYXNJRCI6IjIwMjMwMDE0MTAzNCIsIm5hbWUiOiLmlrnotoUiLCJleHAiOjE3NzA2NTUxNTB9.FWLq2cVjJ0YAfVdFwsqE_bQbYnHqgZ0H_yjQnOLas-8', // 添加token参数
              //       },
              //     );
              // if (!mounted) return;
              //     if (response.statusCode == 200) {
              //       navigate(context, Zhuye());
              //       printToast("登录成功");
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
