import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void suggestion() {
    setState(() {
      isSearching = true;
    });
  }

  Widget _buildSuggestionChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 83, 83, 83),
        ),
      ),
      backgroundColor: const Color.fromARGB(100, 201, 201, 201),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isSearching) {
      return SizedBox(
        width: 355,
        height: 40,
        child: GestureDetector(
          onTap: suggestion,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 355,
              height: 40,
              color: const Color.fromARGB(200, 201, 201, 201),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 83, 83, 83),
                controller: _controller,
                decoration: const InputDecoration(
                  iconColor: Color.fromARGB(255, 83, 83, 83),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 355,
            height: 40,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                width: 355,
                height: 40,
                color: const Color.fromARGB(200, 201, 201, 201),
                child: TextField(
                  cursorColor: const Color.fromARGB(255, 83, 83, 83),
                  controller: _controller,
                  decoration: const InputDecoration(
                    iconColor: Color.fromARGB(255, 83, 83, 83),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(200, 201, 201, 201),
            width: 355,
            height: 141,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Wrap(
                spacing: 24,
                runSpacing: 12,
                children: [
                  _buildSuggestionChip('清新'),
                  _buildSuggestionChip('风景'),
                  _buildSuggestionChip('人像'),
                  _buildSuggestionChip('毕业照'),
                  _buildSuggestionChip('复古'),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
