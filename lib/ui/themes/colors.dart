import 'package:flutter/material.dart';

var primary1 = const Color(0xFFF9F0EC);

var primary2 = const Color(0xfffffae3d8);

var primary3 = const Color(0xFFEAB497); 

//弹窗
var qianlan = const Color.fromARGB(255, 223, 233, 243);

var qianhuang = const Color.fromARGB(255, 235, 235, 213);

var qianhui = const Color.fromARGB(255, 215, 215, 215);

//渐变
var pinkGradient = LinearGradient(
  begin: Alignment.topCenter, 
  end: Alignment.bottomCenter, 
  colors: [
    primary1, 
    primary2, 
  ],
);

var lhGradient = LinearGradient(
  begin: Alignment.topCenter, 
  end: Alignment.bottomCenter, 
  colors: [
    qianlan, 
    qianhuang, 
  ],
);

//搭建一个页面的模板,没滚动
// import 'package:flutter/material.dart';
// import 'package:we_pai/ui/widget/background.dart';
// import 'package:we_pai/ui/widget/up_edge.dart';
// import 'package:we_pai/ui/widget/problems.dart';

// class Yijianfankui extends StatefulWidget {
//   const Yijianfankui({super.key});

//   @override
//   State<Yijianfankui> createState() => _YijianfankuiState();
// }

// class _YijianfankuiState extends State<Yijianfankui> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Background(imagePath: 'lib/material/background2.png'),
          
//           Positioned(top: 20, left: 23, right: 23, child: UpEdge(title: '意见反馈')),

//            Align(
//             alignment: Alignment.centerLeft, 
//             child: Padding(
//               padding: EdgeInsets.only(top: 50), 
//               child: Problems(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }