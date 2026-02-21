import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';

class Wanshanziliao extends StatefulWidget {
  const Wanshanziliao({super.key});

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

          Positioned(top: 72, left: 23, child: UpEdge(title: '完善资料')),
        ],
      ),
    );
  }
}
