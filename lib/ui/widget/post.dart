import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/fabiao.dart';

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
          navigate(context, Fabiao());
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
