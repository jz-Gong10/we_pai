import 'package:flutter/material.dart';
import 'package:we_pai/ui/page/wanshanziliao.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/themes/colors.dart';

class UserShow extends StatefulWidget {
  final String name;
  final String casId;
  final String? avatarUrl;
  final bool change;

  const UserShow({
    super.key,
    required this.name,
    required this.casId,
    this.avatarUrl,
    required this.change,
  });

  @override
  State<UserShow> createState() => _UserShowState();
}

class _UserShowState extends State<UserShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: primary3, width: 1),
        gradient: pinkGradient,
      ),

      child: Row(
        children: [
          // 圆形头像
          Container(
            margin: EdgeInsets.only(left: 30),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: qianhui,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            clipBehavior: Clip.hardEdge,
            child: (widget.avatarUrl?.isNotEmpty ?? false)
                ? Image.network(
                    widget.avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 图片加载失败时显示默认头像
                      return Container(
                        color: qianhui,
                        child: Icon(Icons.person, size: 50, color: Colors.grey),
                      );
                    },
                  )
                : Container(
                    color: qianhui,
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ), // 无URL时显示默认头像
          ),

          // 用户名和ID
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 3),
                      //Icon(Icons.camera_alt_outlined, size: 20),
                      //如果chage=true,有修改按钮
                      if (widget.change)
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {
                              navigate(
                                context,
                                Wanshanziliao(userType: 'photographer'),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'id:${widget.casId}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          // //如果chage=true,有修改按钮
          // if (widget.change)
          //   Container(
          //     margin: EdgeInsets.only(right: 20),
          //     child: IconButton(
          //       onPressed: () {
          //         navigate(context, Wanshanziliao(userType: 'photographer'));
          //       },
          //       icon: Icon(Icons.edit),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
