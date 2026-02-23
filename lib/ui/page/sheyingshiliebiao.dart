import 'package:flutter/material.dart';
import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/up_edge.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/ui/widget/zuopin_show_block.dart';
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
  int orderCount = 5;

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
      var results = await Future.wait([
        _apiService.getPhotographers_total(),
        _apiService.getPhotographers(),
      ]);

      setState(() {
        total = results[0] as int;
        _photographers = results[1] as List<SYSList>;

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
            top: 72,
            left: 23,
            right: 23,
            child: UpEdge(title: '摄影师列表'),
          ),

          Positioned(top: 119, left: 43, child: Search()),

          Positioned(
            top: 180,
            left: 42,
            child: ListView.builder(
              itemCount: total,
              itemBuilder: (context, index) {
                return SYSShowBlock(
                  nickname: _photographers[index].nickname,
                  avatarUrl: _photographers[index].avatarUrl,
                  orderCount: _photographers[index].orderCount,
                  casId: _photographers[index].casId,
                  style: _photographers[index].style,
                  type: _photographers[index].type,
                );
              },
            ),
          ),

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
