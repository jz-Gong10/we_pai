import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';

class Fankui extends StatelessWidget {
  const Fankui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          Positioned(top: 30, left: 23, right: 23, child: UpEdge(title: '意见反馈')),

           Align(
            alignment: Alignment.center, 
            child: Padding(
              padding: EdgeInsets.only(top: 45,left:20), 
              child: Smile(),
            ),
          ),
        ],
      ),
    );
  }
}

class Smile extends StatelessWidget{
  const Smile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 210,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/material/smile.png'),
          fit: BoxFit.cover,
        ),
      ),
      
    );
  }
}
