import 'package:flutter/material.dart';
import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/ui/widget/photographer_show_block.dart';
import 'package:we_pai/ui/widget/progress_indicator.dart';

class SheyingshiliebiaoPage extends StatefulWidget {
  const SheyingshiliebiaoPage({super.key});

  @override
  State<SheyingshiliebiaoPage> createState() => _SheyingshiliebiaoPageState();
}

class _SheyingshiliebiaoPageState extends State<SheyingshiliebiaoPage> {
  final ApiService _apiService = ApiService();
  List<SYSList> _photographers = [];
  int total = 0;

  String? _error;
  bool _isLoading = false;

  String nickname = '昵称';
  String casId = '000000';
  String avatarUrl = '';
  String type = '';
  String style = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      List<SYSList> photographers = await _apiService.getPhotographers();
      debugPrint('数据获取成功，数量: ${photographers.length}'); //看看接没接到数据
      setState(() {
        _photographers = photographers;

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned(
            top: 180,
            left: 42,
            width: 356,
            height: 750,
            child: Container(
              color: Colors.red.withOpacity(0.3), //测试
              child: ListView.builder(
                itemCount: _photographers.length,
                itemBuilder: (context, index) {
                  final SYSList pho = _photographers[index];
                  return SYSShowBlock(
                    nickname: pho.nickname,
                    avatarUrl: pho.avatarUrl,
                    orderCount: pho.orderCount,
                    casId: pho.casId,
                    style: pho.style,
                    type: pho.type,
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 72,
            left: 23,
            right: 23,
            child: UpEdge(title: '摄影师列表'),
          ),

          Positioned(top: 119, left: 43, child: Search()),

          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Color.fromARGB(0, 0, 0, 0),
                child: const Center(child: CircularProgress()),
              ),
            ),
        ],
      ),
    );
  }
}
