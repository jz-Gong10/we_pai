import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> _hotSuggestions = ['清新', '风景', '人像', '毕业照', '复古'];
  final List<String> _searchHistory = ['学线移动', '难写', '算了，继续写'];

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
                    children: _hotSuggestions
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
                ..._searchHistory.map(
                  (history) => ListTile(title: Text(history)),
                ),
              ];
            },
      ),
    );
  }
}
