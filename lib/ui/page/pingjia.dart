import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/star_comment.dart';
import 'package:we_pai/ui/widget/up_edge.dart';

class Pingjia extends StatefulWidget {
  const Pingjia({super.key});

  @override
  State<Pingjia> createState() => _PingjiaState();
}

class _PingjiaState extends State<Pingjia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 72, left: 23, right: 23, child: UpEdge(title: '评价')),

          Positioned(
            top: 342,
            left: 80,
            child: Container(height: 331, width: 280, child: RatingPage()),
          ),
        ],
      ),
    );
  }
}
