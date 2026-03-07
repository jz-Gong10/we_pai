//草稿箱，负责发起请求，管理数据列表，并将数据传递给Displaydraft组件
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/displaydraft.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/api/api_service.dart';
import 'package:we_pai/model/draft_model.dart';

class DisplayDrafts extends StatefulWidget {
  const DisplayDrafts({super.key});

  @override
  State<DisplayDrafts> createState() => _DisplayDraftsState();
}

class _DisplayDraftsState extends State<DisplayDrafts> {
  //定义状态变量，用于存储草稿列表数据
  List<DraftModel> _draftList = [];
  bool _isLoading = true; // 加载状态，防止白屏
  String _error = ''; // 错误信息

  @override
  void initState() {
    super.initState();
    // 页面加载时调用接口
    _fetchDraftData();
  }

  Future<void> _fetchDraftData() async {
    try {
      // 调用ApiService中的方法获取草稿列表数据
      DraftResponse response = await ApiEnquiry.fetchDraftList(1, 10);
      setState(() {
        // 检查 response.data 的类型
        if (response.data is DraftData) {
          _draftList = response.data.list;
        } else {
          // 如果不是 DraftData 类型，设置为空列表
          _draftList = [];
        }
        _isLoading = false; // 数据加载完成，更新加载状态
      });
    } catch (e) {
      setState(() {
        _error = e.toString(); // 捕获错误信息并存储
        _isLoading = false; // 更新加载状态
      });
    }
  }

  //页面设计
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // 返回按钮
        leading: Padding(
          padding: const EdgeInsets.only(left: 9),
          child: AppBackButton(),
        ),
      ),

      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Positioned.fill(
            child: _buildContent(), //搭建页面内容
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator()); // 显示加载指示器
    } else if (_error.isNotEmpty) {
      return Text('错误: $_error'); // 显示错误信息
    } else if (_draftList.isEmpty) {
      return Center(child: Text('没有草稿')); // 显示没有数据的提示
    } else {
      // 显示草稿列表
      return ListView.builder(
        itemCount: _draftList.length,
        itemBuilder: (context, index) {
          return Displaydraft(
            //传递数据给子组件displaydraft
            draft: _draftList[index],
          );
        },
      );
    }
  }
}
