import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/module/announcement_model.dart';
import 'dart:async';

class ShowYouzhizuopin extends StatefulWidget {
  const ShowYouzhizuopin({super.key});

  @override
  State<ShowYouzhizuopin> createState() => _ShowYouzhizuopinState();
}

class _ShowYouzhizuopinState extends State<ShowYouzhizuopin> {
  final ApiService apiService = ApiService();
  List<Announcement> announcement = [];
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
      List<Announcement> announcementsR = await apiService.getAnnouncements();
      setState(() {
        announcement = announcementsR;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = '获取公告失败: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: announcement.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    announcement[index].title +
                        '\n' +
                        announcement[index].content,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
    );
  }
}
