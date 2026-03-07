import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_pai/service/dio_service.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/page/zhuye.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'package:we_pai/ui/widget/progress_indicator.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:we_pai/ui/page/my_works.dart';
import 'package:we_pai/ui/page/wode.dart';
import 'package:we_pai/ui/page/drafts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:we_pai/net/http.dart';
import 'package:we_pai/ui/page/comments.dart';

//测试
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashPage());
  }
}

// 启动页，检查是否有本地token
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkToken();//检查是否本地有token
  }

  Future<void> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // 有token，设置到Http并跳转到主页
      Http().setToken(token);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Zhuye()),
        );
      }
    } else {
      // 没有token，跳转到登录页
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
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
            top: 250,
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
            top: 730,
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

              // 登录按钮点击事件
              onPressed: () async {
                await _login();
              },

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

  Future<void> _login() async {
    setState(() {
      _loading = true;
    });
    try {//跳转到山大的登录页
      String url =
          'https://i.sdu.edu.cn/cas/proxy/login/page?forward=http%3A%2F%2F172.24.37.149%3A8080%2Flogin%3Fplatform%3Dmobile';
      final authUrl = Uri.parse(url);

      final result = await FlutterWebAuth2.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: 'wepai',
      );

      final backUri = Uri.parse(result);
      debugPrint('$backUri\n-----------------');
      final token = backUri.queryParameters['token'];//获取token
      final casId = backUri.queryParameters['casId'];
      final name = backUri.queryParameters['name'];
      if (token == null) {//获取token失败
        printToast("登录失败");
        debugPrint("登录失败: token is null");
        setState(() {
          _loading = false;
        });
        return;
      }
      debugPrint("token: $token \ncasId: $casId \nname: $name");

      // 存储token到本地
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      if (casId != null) {
        await prefs.setString('casId', casId);
      }
      if (name != null) {
        await prefs.setString('name', name);
      }

      // 设置Dio的token
      DioService().setToken(token);

      // 跳转到主页
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Zhuye()),
      );
    } catch (e) {
      printToast("登录失败: $e");
      debugPrint("登录失败: $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
