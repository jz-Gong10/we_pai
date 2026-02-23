import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/user_show.dart';
import 'package:we_pai/module/recieve_zishenxinxi.dart';

class Wode extends StatefulWidget {
  const Wode({super.key});

  @override
  State<Wode> createState() => _WodeState();
}

class _WodeState extends State<Wode> {
  final ApiService _apiService = ApiService();
  String? _error;
  String name = '未知用户';
  String casId = '000000';
  String avatarUrl = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _error = null;
    });
    try {
      // 并发请求示例
      var result = await Future.wait([_apiService.getUserInfo()]);

      setState(() {
        name = result[0].name;
        casId = result[0].casId;
        avatarUrl = result[0].avatarUrl;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

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
