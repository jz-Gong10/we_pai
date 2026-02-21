import 'dart:async';
import 'package:flutter/material.dart';
import 'package:we_pai/module/recieve_zishenxinxi.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/post.dart';
import 'package:we_pai/ui/widget/print.dart';
import 'package:we_pai/ui/widget/zhuye_low_edge.dart';
import 'package:we_pai/ui/widget/options.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/ui/widget/show_youzhizuopin.dart';
import 'package:we_pai/net/http.dart';

class Zhuye extends StatefulWidget {
  const Zhuye({super.key});

  @override
  State<Zhuye> createState() => _ZhuyeState();
}

class _ZhuyeState extends State<Zhuye> {
  String? _imagePath = 'lib/material/term_for_usage.png';
  bool _isVisible = true;

  String name = '';
  String casId = '';
  String avatarUrl = '';

  // 接收自身信息(网络请求并获取返回数据模板)
  UserInfo? _userInfo;
  bool _loadingProfile = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loadingProfile = true;
    });
    try {
      final response = await Http().get(path: '/user/getProfile');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;
        final Map<String, dynamic>? userData =
            responseData['data'] as Map<String, dynamic>?;
        if (userData != null) {
          setState(() {
            _userInfo = UserInfo.fromJson(userData);

            //获取个人数据
            name = _userInfo!.name;
            casId = _userInfo!.casId;
            avatarUrl = _userInfo!.avatarUrl ?? '';
          });
        }
      } else {
        printToast('个人数据同步失败：${response.statusCode}');
      }
    } catch (e) {
      debugPrint('load profile error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _loadingProfile = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          //下方状态栏
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ZhuyeLowEdge(name: name, casId: casId, avatarUrl: avatarUrl),
          ),

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

          //搜索框
          Positioned(top: 66, left: 42, child: Search()),

          //作品展示
          Positioned(top: 140, left: 27, child: ShowYouzhizuopin()),

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
