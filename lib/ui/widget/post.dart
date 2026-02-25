import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/choose.dart';

void navigate(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      height: 108,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          navigate(context, Choose());
        },
        child: Container(
          width: 105,
          height: 108,
          alignment: Alignment.center,
          child: Image.asset('lib/material/post.png'),
        ),
      ),
    );
  }
}

//下方状态栏
// Positioned(bottom: 0, left: 0, right: 0, child: ZhuyeLowEdge()),

// //发布按钮
// Positioned(
//   bottom: 22,
//   left: MediaQuery.of(context).size.width / 2 - 105 / 2,
//   child: Post(),
// ),
