import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/ruzhu.dart';
import 'package:we_pai/ui/page/wode.dart';

void navigate(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

class ZhuyeLowEdge extends StatefulWidget {
  final String name;
  final String casId;
  final String avatarUrl;
  const ZhuyeLowEdge({
    super.key,
    required this.name,
    required this.casId,
    required this.avatarUrl,
  });

  @override
  State<ZhuyeLowEdge> createState() => _ZhuyeLowEdgeState();
}

class _ZhuyeLowEdgeState extends State<ZhuyeLowEdge> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Expanded(
          child: Container(
            height: 77,
            decoration: BoxDecoration(
              color: Color(0xffFFE0CE),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFE0CE),
                foregroundColor: Color(0xffFFE0CE),
                shadowColor: Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () {
                navigate(context, Ruzhu());
              },
              child: Image.asset('lib/material/ruzhu.png'),
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: 77,
            decoration: BoxDecoration(
              color: Color(0xffFFE0CE),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFE0CE),
                foregroundColor: Color(0xffFFE0CE),
                shadowColor: Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () {
                navigate(
                  context,
                  Wode(
                    name: widget.name,
                    casId: widget.casId,
                    avatarUrl: widget.avatarUrl,
                  ),
                );
              },
              child: Image.asset('lib/material/wode.png'),
            ),
          ),
        ),
      ],
    );
  }
}
