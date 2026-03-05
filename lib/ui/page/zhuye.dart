import 'dart:async';
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/post.dart';
import 'package:we_pai/ui/widget/zhuye_low_edge.dart';
import 'package:we_pai/ui/widget/options.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/ui/widget/show_youzhizuopin.dart';

class Zhuye extends StatefulWidget {
  const Zhuye({super.key});

  @override
  State<Zhuye> createState() => _ZhuyeState();
}

class _ZhuyeState extends State<Zhuye> {
  String? _error;
  bool _isLoading = false;
  String? _imagePath = 'lib/material/term_for_usage.png';
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          //搜索框
          Positioned(
            top: screenHeight * 0.08, // 相对高度
            left: 20,
            right: 20,
            child: Center(child: Search()),
          ),

          //作品展示
          Positioned(
            top: screenHeight * 0.18, // 相对高度
            left: 20,
            right: 20,
            child: Center(child: ShowYouzhizuopin()),
          ),

          //选项按钮容器
          Positioned(
            top: screenHeight * 0.4, // 相对高度
            left: 0,
            right: 0,
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // 计算容器宽度，最大396，最小280，根据屏幕宽度调整
                  double containerWidth = screenWidth * 0.8;
                  containerWidth = containerWidth.clamp(280.0, 396.0);

                  // 计算比例
                  double scale = containerWidth / 396.0;

                  return Container(
                    width: containerWidth, // 响应式宽度
                    height: 421 * scale, // 按比例调整高度
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Transform.scale(
                            scale: scale,
                            child: Kedanguangchang(),
                          ),
                        ),
                        Positioned(
                          left: 180 * scale,
                          top: 0,
                          child: Transform.scale(
                            scale: scale,
                            child: Sheyingshiliebiao(),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 221 * scale,
                          child: Transform.scale(
                            scale: scale,
                            child: Zuopinzhanshi(),
                          ),
                        ),
                        Positioned(
                          left: 186 * scale,
                          top: 147 * scale,
                          child: Transform.scale(
                            scale: scale,
                            child: Sheyingshijianquan(),
                          ),
                        ),
                        Positioned(
                          left: 186 * scale,
                          top: 284 * scale,
                          child: Transform.scale(
                            scale: scale,
                            child: Paihangbang(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          //下方状态栏
          Positioned(bottom: 0, left: 0, right: 0, child: ZhuyeLowEdge()),

          //发布按钮
          Positioned(
            bottom: 22,
            left: screenWidth / 2 - 105 / 2,
            child: Post(),
          ),

          //使用条款确认和消失
          Positioned.fill(
            child: Visibility(
              visible: _isVisible,
              child: Align(
                alignment: Alignment.center,
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
                  child: Container(
                    width: screenWidth * 0.8, // 响应式宽度
                    height: screenWidth * 1.03, // 按比例调整高度
                    child: (_imagePath != null && _imagePath!.isNotEmpty)
                        ? Image.asset(_imagePath!, fit: BoxFit.contain)
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
