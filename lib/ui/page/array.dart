//摄影师排行榜
import 'package:flutter/material.dart';
import 'package:we_pai/module/recieve_sheyingshijiedan.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/widget/search.dart';
import 'package:we_pai/ui/widget/show_youzhizuopin.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/module/recieve_sheyingshijiedan.dart';
import 'package:we_pai/service/api_service.dart';

class Array extends StatefulWidget {
  const Array({super.key});

  @override
  State<Array> createState() => _ArrayState();
}

class _ArrayState extends State<Array> {
  final ApiService _apiService = ApiService();
  String? _error;
  bool _isLoading = false;
  bool _isRatingRanking = true;
  //测试数据
  // final List<Map<String, dynamic>> _photographers = [
  //   {
  //     'avatar': 'https://via.placeholder.com/48',
  //     'nickname': '摄影师1',
  //     'rating': 4.9,
  //     'orders': 120,
  //   },
  //   {
  //     'avatar': 'https://via.placeholder.com/48',
  //     'nickname': '摄影师2',
  //     'rating': 4.8,
  //     'orders': 115,
  //   },
  //   {
  //     'avatar': 'https://via.placeholder.com/48',
  //     'nickname': '摄影师3',
  //     'rating': 4.7,
  //     'orders': 110,
  //   },
  //   {
  //     'avatar': 'https://via.placeholder.com/48',
  //     'nickname': '摄影师4',
  //     'rating': 4.6,
  //     'orders': 105,
  //   },
  //   {
  //     'avatar': 'https://via.placeholder.com/48',
  //     'nickname': '摄影师5',
  //     'rating': 4.5,
  //     'orders': 100,
  //   },
  // ];

  List<SYOrder> photographers = [];
  List<SYOrder> photographers2 = [];

  @override
  void initState() {
    super.initState();
    _loadPhotographers();
    _load();
  }

  Future<void> _loadPhotographers() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      List<SYOrder> response = await _apiService.getSYOrder();
      setState(() {
        photographers = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _load() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      List<SYOrder> response = await _apiService.getSYRating();
      setState(() {
        photographers2 = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  // 可以切换是按评分还是按接单量排序
  List<Map<String, dynamic>> get _sortedPhotographers {
    if (_isRatingRanking) {
      return List.from(photographers2)
        ..sort((a, b) => b['rating'].compareTo(a['rating']));
    } else {
      return List.from(photographers)
        ..sort((a, b) => b['orders'].compareTo(a['orders']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          //返回按钮
          Positioned(top: 40, left: 23, child: AppBackButton()),
          //搜索栏
          Positioned(top: 30, left: 63, right: 20, child: Search()),

          Positioned(
            top: 90,
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const ShowYouzhizuopin(imageURL: ''), //这里在widget里面再完善一下
                  const SizedBox(height: 30),
                  _buildRankingToggle(),
                  const SizedBox(height: 40),
                  ..._sortedPhotographers.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _buildPhotographerCard(entry.key, entry.value),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingToggle() {
    //切换评分排行榜还是接单排行榜的按钮
    return Container(
      width: 280,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [primary3, primary2]),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isRatingRanking = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _isRatingRanking
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '评分排行榜',
                    style: TextStyle(
                      color: Colors.white,
                      //文字阴影
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.grey,
                          offset: Offset(-1, 2), // 文字阴影偏移
                        ),
                      ],
                      fontSize: 14,
                      fontWeight: _isRatingRanking
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isRatingRanking = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !_isRatingRanking
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '接单量排行榜',
                    style: TextStyle(
                      color: Colors.white,
                      //文字阴影
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.grey,
                          offset: Offset(-1, 2), // 文字阴影偏移
                        ),
                      ],
                      fontSize: 14,
                      fontWeight: !_isRatingRanking
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotographerCard(int index, Map<String, dynamic> photographer) {
    return Center(
      child: Container(
        width: 250,
        height: 80,
        decoration: BoxDecoration(
          color: primary2,
          borderRadius: BorderRadius.circular(10),

          //边框阴影
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4, //模糊半径
              offset: Offset(0, 4), //偏移量(x, y)，向下偏移产生投影
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 12,
              child: Text(
                'NO.${index + 1}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 222, 152, 115),
                  //文字阴影
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.grey,
                      offset: Offset(0, 2), // 文字阴影偏移
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 28,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(photographer['avatar']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 60,
              child: Text(
                photographer['nickname'],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  //文字阴影
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.grey,
                      offset: Offset(0, 2), // 文字阴影偏移
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 25,
              right: 12,
              child: Text(
                _isRatingRanking
                    ? '${photographer['rating']}'
                    : '${photographer['orders']}单',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 222, 152, 115),
                  //文字阴影
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.grey,
                      offset: Offset(0, 2), // 文字阴影偏移
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  //跳转逻辑（还没写）
                },
                child: Text(
                  'TA的主页',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 222, 152, 115),
                    //文字阴影
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.grey,
                        offset: Offset(0, 2), // 文字阴影偏移
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
