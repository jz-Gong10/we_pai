import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/problems.dart';

class Yijianfankui extends StatefulWidget {
  const Yijianfankui({super.key});

  @override
  State<Yijianfankui> createState() => _YijianfankuiState();
}

class _YijianfankuiState extends State<Yijianfankui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: '意见反馈')),

           Align(
            alignment: Alignment.centerLeft, 
            child: Padding(
              padding: EdgeInsets.only(top: 50), 
              child: Problems(),
            ),
          ),
        ],
      ),
    );
  }
}
