import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/user_show.dart';
import 'package:we_pai/module/recieve_zishenxinxi.dart';
import 'package:we_pai/shared_preference/user_storage.dart';

class Wode extends StatefulWidget {
  const Wode({super.key});

  @override
  State<Wode> createState() => _WodeState();
}

class _WodeState extends State<Wode> {
  UserInfo? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await UserStorage.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = '未知用户';
    String casId = '';
    String? avatarUrl;

    if (_user != null) {
      setState(() {
        name = _user!.name;
        casId = _user!.casId;
        avatarUrl = _user!.avatarUrl ?? '';
      });
    } else {
      return Scaffold(
        body: Stack(
          children: [
            Background(imagePath: 'lib/material/background2.png'),

            Positioned(top: 72, left: 23, child: UpEdge(title: '个人主页')),

            Positioned(
              top: 155,
              left: 25,
              child: UserShow(name: '未知用户', casId: '000000', avatarUrl: ''),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(top: 72, left: 23, child: UpEdge(title: '个人主页')),

          Positioned(
            top: 155,
            left: 25,
            child: UserShow(
              name: name,
              casId: casId,
              avatarUrl: avatarUrl ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
