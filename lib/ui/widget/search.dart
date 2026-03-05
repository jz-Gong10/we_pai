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

  static const Color searchBarColor = Color.fromARGB(255, 201, 201, 201);

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: SearchAnchor(
            viewBackgroundColor: searchBarColor,
            viewConstraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
            ),
            viewLeading: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // 点击搜索按钮执行搜索逻辑
              },
            ),
            builder: (BuildContext context, SearchController controller) {
              return SizedBox(
                width: constraints.maxWidth,
                height: 40,
                child: SearchBar(
                  controller: controller,
                  leading: const Icon(Icons.search),
                  backgroundColor: WidgetStateProperty.all(searchBarColor),
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
                    Container(
                      color: searchBarColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: hotSuggestions
                              .map(
                                (suggestion) => Chip(
                                  label: Text(
                                    suggestion,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                    ),
                                  ),
                                  backgroundColor: searchBarColor,
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    width: 1,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),

                    //搜索历史记录
                    if (searchHistory.isNotEmpty)
                      Container(
                        color: searchBarColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '搜索历史',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 83, 83, 83),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 16,
                                  color: Color.fromARGB(255, 83, 83, 83),
                                ),
                                onPressed: () {
                                  // 清空搜索历史
                                  setState(() {
                                    searchHistory = [];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                    // 搜索历史记录列表
                    ...searchHistory.map(
                      (history) => Container(
                        color: searchBarColor,
                        child: InkWell(
                          onTap: () {
                            // 点击历史记录，填充到搜索框并执行搜索
                            controller.text = history;
                            print('搜索: $history');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              history,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // 无搜索历史时显示
                    if (searchHistory.isEmpty)
                      Container(
                        color: searchBarColor,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Text(
                            '暂无搜索历史',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 120, 120, 120),
                            ),
                          ),
                        ),
                      ),
                  ];
                },
          ),
        );
      },
    );
  }
}
