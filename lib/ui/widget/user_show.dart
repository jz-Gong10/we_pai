import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/wanshanziliao.dart';
import 'package:we_pai/ui/widget/background.dart';

class UserShow extends StatefulWidget {
  final String name;
  final String casId;
  String? avatarUrl;

  UserShow({
    super.key,
    required this.name,
    required this.casId,
    this.avatarUrl,
  });

  @override
  State<UserShow> createState() => _UserShowState();
}

class _UserShowState extends State<UserShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 389,
      height: 124,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF9F0EC), Color(0xFFFAE3D8)],
        ),
      ),

      child: SizedBox(
        width: 246,
        height: 100,
        child: Row(
          children: [
            Container(
              color: Colors.grey,
              width: 100,
              height: 100,
              margin: EdgeInsets.only(left: 49, right: 20, top: 12, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Image.network(widget.avatarUrl ?? ''),
            ),

            Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.casId,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),

            SizedBox(
              child: IconButton(
                onPressed: () {
                  navigate(context, Wanshanziliao());
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
