import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';
import 'package:we_pai/ui/widget/photographer_show_block.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ApiService _apiService = ApiService();

  List<String> hotSuggestions = ['清新', '风景', '人像', '毕业照', '复古', '花开富贵'];
  List<String> searchHistory = [];
  List<SYSList> searchResults = [];
  bool isSearching = false;
  String? searchKeyword;

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

  // 执行搜索
  Future<void> _performSearch(String keyword) async {
    if (keyword.isEmpty) return;

    // 立即更新UI，显示加载状态和搜索关键词
    setState(() {
      isSearching = true;
      searchKeyword = keyword;
      // 清空之前的搜索结果，避免显示旧数据
      searchResults = [];
    });

    try {
      // 执行搜索
      List<SYSList> results = await _apiService.getPhotographers(
        keyword: keyword,
      );

      // 搜索完成后更新结果
      setState(() {
        searchResults = results;
        isSearching = false;
        // 添加到搜索历史
        if (!searchHistory.contains(keyword)) {
          searchHistory.insert(0, keyword);
          // 限制历史记录数量
          if (searchHistory.length > 10) {
            searchHistory = searchHistory.sublist(0, 10);
          }
        }
      });
    } catch (e) {
      setState(() {
        isSearching = false;
        searchResults = [];
      });
      print('搜索失败: $e');
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
              onSubmitted: (value) {
                _performSearch(value);
              },
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              // 如果正在搜索，显示加载状态
              if (isSearching) {
                return [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ];
              }

              // 如果有搜索结果，显示结果
              if (searchKeyword != null && searchResults.isNotEmpty) {
                return [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '搜索 "$searchKeyword" 的结果',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...searchResults.map(
                    (result) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SYSShowBlock(
                        nickname: result.nickname,
                        casId: result.casId,
                        avatarUrl: result.avatarUrl,
                        orderCount: result.orderCount,
                        style: result.style,
                        type: result.type,
                        equipment: result.equipment,
                      ),
                    ),
                  ),
                ];
              }

              // 如果搜索结果为空，显示提示
              if (searchKeyword != null && searchResults.isEmpty) {
                return [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '未找到与 "$searchKeyword" 相关的结果',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ];
              }

              // 默认显示热门搜索和历史记录
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
                          (suggestion) => ActionChip(
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
                            onPressed: () {
                              _performSearch(suggestion);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),

                //搜索历史记录
                if (searchHistory.isNotEmpty)
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
                  (history) => ListTile(
                    title: Text(history),
                    onTap: () {
                      _performSearch(history);
                    },
                  ),
                ),
              ];
            },
      ),
    );
  }
}
