import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/ziliaocard.dart';

class Wanshanziliao extends StatefulWidget {
  final String userType;

  const Wanshanziliao({super.key, required this.userType});

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

          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: '完善资料')),

           Align(
            alignment: Alignment.topCenter, 
            child: Padding(
            padding: EdgeInsets.only(top: 155), 
            child: widget.userType == 'client' ? Ziliaocard() : Ziliaocard1(),
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