import 'package:flutter/material.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:we_pai/model/announcement_model.dart';
import 'dart:async';

class ShowAnouncement extends StatefulWidget {
  const ShowAnouncement({super.key});

  @override
  State<ShowAnouncement> createState() => _ShowAnouncementState();
}

class _ShowAnouncementState extends State<ShowAnouncement> {
  final ApiService apiService = ApiService();
  List<AnnouncementItem> announcements = [];
  bool _isLoading = false;
  String? _error;
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchAnnouncement();
    // 设置自动轮播
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // 开始自动轮播
  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (announcements.length > 1 && _pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= announcements.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // 从API获取公告
  Future<void> _fetchAnnouncement() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      List<AnnouncementItem> announcementsR = await apiService.getAnnouncements();
      setState(() {
        announcements = announcementsR;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = '获取公告失败: $e';
        _isLoading = false;
      });
    }
  }

  // 格式化日期时间
  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Center(
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (announcements.isEmpty) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: const Center(
          child: Text(
            '暂无公告',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: PageView.builder(
          controller: _pageController,
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    announcement.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', // Material 字体
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // 更新时间
                  Text(
                    _formatDateTime(announcement.updatedAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 内容
                  Expanded(
                    child: Text(
                      announcement.content,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
