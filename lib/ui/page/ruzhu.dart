import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/yaoqingma.dart';
import 'package:we_pai/net/http.dart';
import 'package:we_pai/ui/widget/progress_indicator.dart';
import 'package:we_pai/ui/widget/touchable_word.dart';

class Ruzhu extends StatefulWidget {
  const Ruzhu({super.key});

  @override
  State<Ruzhu> createState() => _RuzhuState();
}

class _RuzhuState extends State<Ruzhu> {
  final TextEditingController _invitationCodeController =
      TextEditingController();
  String _invitationCode = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _invitationCodeController.addListener(() {
      setState(() {
        _invitationCode = _invitationCodeController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          //顶部标题和返回按钮
          Positioned(top: 72, left: 23, right: 23, child: UpEdge(title: '入驻')),

          //提示文字
          Positioned(
            top: 188,
            left: 46,
            child: SizedBox(
              width: 328,
              height: 94,
              child: Image.asset('lib/material/lijiruzhu_words.png'),
            ),
          ),

          //邀请码输入
          Positioned(
            top: 363,
            left: 30,
            right: 30,
            child: Yaoqingma(controller: _invitationCodeController),
          ),

          //提交按钮
          Positioned(
            top: 730,
            left: 93,
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
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                try {
                  if (_invitationCode.isNotEmpty) {
                    final response = await Http().post(
                      path:
                          'http://127.0.0.1:4523/m1/7790878-7537573-default/photographer/enroll',
                      data: {'invitationCode': _invitationCode},
                    );
                    if (!mounted) return;
                    if (response.statusCode == 200) {
                      // 打印接口返回的msg字段
                      printToast(response.data['msg'].toString());
                    } else {
                      printToast('入驻失败: ${response.statusCode}');
                    }
                  } else {
                    printToast('请输入邀请码');
                  }
                } finally {
                  setState(() {
                    _loading = false;
                  });
                }
              },
            ),
          ),

          //图片装饰
          Positioned(
            top: 505,
            left: 57,
            child: SizedBox(
              width: 325,
              height: 150,
              child: Image.asset('lib/material/ruzhu_word.png'),
            ),
          ),

          //意见反馈文字按钮
          Positioned(
            top: 806,
            left: 135,
            child: TouchableWord(content: '不满意？点击此处反馈意见'),
          ),

          //加载中
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
