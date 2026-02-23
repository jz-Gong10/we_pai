import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/wanshanziliao.dart';
import 'package:we_pai/ui/widget/background.dart';

class UserShow extends StatefulWidget {
  final String name;
  final String casId;
  final String avatarUrl;

  UserShow({
    super.key,
    required this.name,
    required this.casId,
    required this.avatarUrl,
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
        height: 105,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 120,
                height: 100,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child:
                      (widget.avatarUrl != null && widget.avatarUrl.isNotEmpty)
                      ? Image.network(
                          widget.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // 图片加载失败时显示默认头像
                            return Icon(
                              Icons.person,
                              size: 24,
                              color: Colors.grey,
                            );
                          },
                        )
                      : Icon(
                          Icons.person,
                          size: 24,
                          color: Colors.grey,
                        ), // 无URL时显示默认头像
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(height: 30),
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
            ),

            Expanded(
              flex: 1,
              child: SizedBox(
                child: IconButton(
                  onPressed: () {
                    navigate(context, Wanshanziliao());
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
