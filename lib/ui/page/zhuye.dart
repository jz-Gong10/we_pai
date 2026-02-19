import 'dart:async';
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/post.dart';
import 'package:we_pai/ui/widget/zhuye_low_edge.dart';
import 'package:we_pai/ui/widget/options.dart';

class Zhuye extends StatefulWidget {
  const Zhuye({super.key});

  @override
  State<Zhuye> createState() => _ZhuyeState();
}

class _ZhuyeState extends State<Zhuye> {
  String? _imagePath = 'lib/material/term_for_usage.png';
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          //下方状态栏
          Positioned(bottom: 0, left: 0, right: 0, child: ZhuyeLowEdge()),

          //发布按钮
          Positioned(
            bottom: 22,
            left: MediaQuery.of(context).size.width / 2 - 105 / 2,
            child: Post(),
          ),

          //选项按钮
          Positioned(top: 369, left: 42, child: Kedanguangchang()),
          Positioned(top: 369, left: 222, child: Sheyingshiliebiao()),
          Positioned(top: 590, left: 42, child: Zuopinzhanshi()),
          Positioned(top: 516, left: 228, child: Sheyingshijianquan()),
          Positioned(top: 663, left: 228, child: Paihangbang()),

          //使用条款确认和消失
          Positioned(
            top: 274.13,
            left: 56,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 327,
                  height: 418.87,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _imagePath = 'lib/material/term_for_usage_ok.png';
                        _isVisible = true;
                      });
                      Timer(const Duration(seconds: 1), () {
                        setState(() {
                          _isVisible = false;
                          _imagePath = null;
                        });
                      });
                    },
                    child: Visibility(
                      visible: _isVisible,
                      child: Container(
                        alignment: Alignment.center,
                        width: 327,
                        height: 418.87,
                        child: (_imagePath != null && _imagePath!.isNotEmpty)
                            ? Image.asset(_imagePath!)
                            : SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
