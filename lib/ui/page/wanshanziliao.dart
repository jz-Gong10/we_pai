import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/ziliaocard.dart';
import 'package:we_pai/module/recieve_zishenxinxi.dart';

class Wanshanziliao extends StatefulWidget {
  final String userType;
  final UserInfo? userInfo;

  const Wanshanziliao({super.key, required this.userType, this.userInfo});

  @override
  State<Wanshanziliao> createState() => _WanshanziliaoState();
}

class _WanshanziliaoState extends State<Wanshanziliao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(
            top: 40,
            left: 23,
            right: 23,
            child: UpEdge(title: '完善资料'),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 155),
              child: widget.userType == 'client'
                  ? Ziliaocard(userInfo: widget.userInfo)
                  : Ziliaocard1(userInfo: widget.userInfo),
            ),
          ),
        ],
      ),
    );
  }
}
// 客户端
// Wanshanziliao(userType: 'kehu')

// 摄影师端
// Wanshanziliao(userType: 'sheyingshi')
