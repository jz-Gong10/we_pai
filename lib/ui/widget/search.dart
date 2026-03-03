import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ApiService _apiService = ApiService();

  List<String> hotSuggestions = ['清新', '风景', '人像', '毕业照', '复古'];
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    // 初始化搜索历史
    _initSearchHistory();
    // 初始化搜索推荐词
    _initSearchRecommendations();
  }

  // 初始化搜索推荐词
  Future<void> _initSearchRecommendations() async {
    try {
      List<String> recommendations = await _apiService
          .getSearchRecommendations();
      setState(() {
        hotSuggestions = recommendations;
      });
    } catch (e) {
      // 处理错误
      print('获取搜索推荐词失败: $e');
    }
  }

  // 初始化搜索历史
  Future<void> _initSearchHistory() async {
    try {
      List<String> history = await _apiService.getSearchHistory();
      setState(() {
        searchHistory = history;
      });
    } catch (e) {
      // 处理错误
      print('获取搜索历史失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SizedBox(
            width: 355,
            height: 40,
            child: SearchBar(
              controller: controller,
              leading: const Icon(Icons.search),
              backgroundColor: WidgetStateProperty.all(
                const Color.fromARGB(200, 201, 201, 201),
              ),
              onTap: () {
                controller.openView();
              },
              onChanged: (value) {
                if (!controller.isOpen) {
                  controller.openView();
                }
              },
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              return [
                // 推荐热门搜索词
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hotSuggestions
                        .map(
                          (suggestion) => Chip(
                            label: Text(
                              suggestion,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 83, 83, 83),
                              ),
                            ),
                            backgroundColor: const Color.fromARGB(
                              100,
                              201,
                              201,
                              201,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                //搜索历史记录
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '搜索历史',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 83, 83, 83),
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        size: 16,
                        color: Color.fromARGB(255, 83, 83, 83),
                      ),
                    ],
                  ),
                ),

                // 搜索历史记录列表
                ...searchHistory.map(
                  (history) => ListTile(title: Text(history)),
                ),
              ];
            },
      ),
    );
  }
}
