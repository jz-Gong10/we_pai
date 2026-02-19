import 'package:flutter/material.dart';

//页面跳转函数
void navigate(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

//背景组件
class Background extends StatelessWidget {
  final String imagePath;
  const Background({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(color: Color(0xffF9F2EF))),

        Container(
          alignment: Alignment.center,
          width: 440,
          height: 956,
          child: Image.asset(imagePath),
        ),
      ],
    );
  }
}


//珍贵垃圾
// class Decoration extends StatelessWidget {
//   final double width;
//   final double height;
//   final double top;
//   final double left;
//   final double top_left;
//   final double top_right;
//   final double bottom_right;
//   final double bottom_left;
//   final double rotation;
//   final int color1;
//   final int color2;
//   final double blur;

//   const Decoration({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.top,
//     required this.left,
//     required this.top_left,
//     required this.top_right,
//     required this.bottom_right,
//     required this.bottom_left,
//     required this.rotation,
//     required this.color1,
//     required this.color2,
//     required this.blur,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: AlignmentGeometry.bottomCenter,
//       fit: StackFit.loose,
//       children: [
//         Transform.rotate(
//           angle: rotation * (3.1415926 / 180),
//           child: Container(
//             width: width,
//             height: height,
//             margin: EdgeInsets.only(top: top, left: left),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(top_left),
//                 topRight: Radius.circular(top_right),
//                 bottomRight: Radius.circular(bottom_right),
//                 bottomLeft: Radius.circular(bottom_left),
//               ),
//               gradient: LinearGradient(
//                 colors: [Color(color1), Color(color2)],
//               ),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(top_left),
//                 topRight: Radius.circular(top_right),
//                 bottomRight: Radius.circular(bottom_right),
//                 bottomLeft: Radius.circular(bottom_left),
//               ),
//             ),
//           ),
//         ),
//         // 虚化处理
//         BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
//           child: Container(
//             color: Colors.transparent,
//           ),
//         ),
//       ],
//     );
//   }
// }

        // Decoration(
        //   width:115.96, 
        //   height:118.35, 
        //   top:14, 
        //   left:10, 
        //   top_left:30,
        //   top_right:80,
        //   bottom_right:40,
        //   bottom_left:20,
        //   rotation:-26.47,
        //   color1:0xffF98C53,
        //   color2:0xffFCCEB4,
        //   blur:4
        // ),

        // Decoration(
        //   width:195, 
        //   height:167, 
        //   top:-59, 
        //   left:290, 
        //   top_left:30,
        //   top_right:80,
        //   bottom_right:70,
        //   bottom_left:100,
        //   rotation:-110.51,
        //   color1:0xff5098D3,
        //   color2:0xffABD7FB,
        //   blur:4
        // ),

        // Decoration(
        //   width:84, 
        //   height:69, 
        //   top:172, 
        //   left:178, 
        //   top_left:40,
        //   top_right:50,
        //   bottom_right:10,
        //   bottom_left:30,
        //   rotation:0,
        //   color1:0xffD2E0AA,
        //   color2:0xffBFDC6A,
        //   blur:4
        // ),

        // Decoration(
        //   width:270, 
        //   height:288, 
        //   top:213, 
        //   left:88, 
        //   top_left:100,
        //   top_right:210,
        //   bottom_right:40,
        //   bottom_left:80,
        //   rotation:37.46,
        //   color1:0xffF6A173,
        //   color2:0xffFEC6A9,
        //   blur:4
        // ),

        // Decoration(
        //   width:96, 
        //   height:99, 
        //   top:510, 
        //   left:24, 
        //   top_left:20,
        //   top_right:20,
        //   bottom_right:80,
        //   bottom_left:30,
        //   rotation:40.44,
        //   color1:0xffD2E0AA,
        //   color2:0xff9CC037,
        //   blur:4
        // ),

        // Decoration(
        //   width:105, 
        //   height:120, 
        //   top:608, 
        //   left:274, 
        //   top_left:20,
        //   top_right:40,
        //   bottom_right:90,
        //   bottom_left:30,
        //   rotation:-60.46,
        //   color1:0xff6EBEFF,
        //   color2:0xffABD7FB,
        //   blur:4
        // ),
        
        // Decoration(
        //   width:225, 
        //   height:234, 
        //   top:666, 
        //   left:-16, 
        //   top_left:40,
        //   top_right:120,
        //   bottom_right:50,
        //   bottom_left:80,
        //   rotation:19.44,
        //   color1:0xffFFBF9C,
        //   color2:0xffF98C53,
        //   blur:4
        // ),





