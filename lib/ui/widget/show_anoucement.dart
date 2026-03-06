import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'dart:async';

class ShowAnouncement extends StatefulWidget {
  const ShowAnouncement({super.key});

  @override
  State<ShowAnouncement> createState() => _ShowAnouncementState();
}

class _ShowAnouncementState extends State<ShowAnouncement> {
  final ApiService apiService = ApiService();
  List<String> announcement = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchAnnouncement();
  }

  // 从API获取公告
  Future<void> _fetchAnnouncement() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      List<String> announcementsR = await apiService.getAnnouncements();
      setState(() {
        announcement = announcementsR;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        announcement = ['获取公告失败: $e'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isError = announcement.first == '获取公告失败';
    
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isError 
            ? const Color.fromARGB(255, 201, 201, 201)  // 搜索栏的颜色（不透明度100%）
            : Colors.grey,  // 原来的背景色
      ),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: announcement.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    announcement[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
    );
  }
}
