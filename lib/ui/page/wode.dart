import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/user_show.dart';

class Wode extends StatefulWidget {
  final String name;
  final String casId;
  final String avatarUrl;
  const Wode({
    super.key,
    required this.name,
    required this.casId,
    required this.avatarUrl,
  });

  @override
  State<Wode> createState() => _WodeState();
}

class _WodeState extends State<Wode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 72, left: 23, child: UpEdge(title: '个人主页')),

          Positioned(
            top: 155,
            left: 25,
            child: UserShow(
              name: widget.name,
              casId: widget.casId,
              avatarUrl: widget.avatarUrl,
            ),
          ),
        ],
      ),
    );
  }
}
