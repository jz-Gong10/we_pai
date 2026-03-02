import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/fabiaozuopin.dart';

//Positioned(top: 72, left: 23, right: 23, child: UpEdge(title: '入驻')),
class UpEdge extends StatelessWidget {
  final String title;

  const UpEdge({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //返回按钮
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              'lib/material/return.png',
              width: 24,
              height: 24,
            ),
          ),
        ),

        //标题
        Expanded(
          flex: 6,
          child: Text(
            title, // 直接使用 final 的 title
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),

        //占位
        Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}

class UppEdge extends StatelessWidget {
  // final String title;

  const UppEdge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //返回按钮
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              'lib/material/return.png',
              width: 24,
              height: 24,
            ),
          ),
        ),

        //标题
        Expanded(
          flex: 6,
          child: Text(
            '我的作品',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),

        //占位
        Expanded(
          flex: 1, 
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: const Color.fromARGB(255, 0, 0, 0),
              size: 24,
            ),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Fabiaozuopin()),
                );
              },
          ),
        ),
      ],
    );
  }
}