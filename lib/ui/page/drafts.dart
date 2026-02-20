//点击草稿箱后跳转到这个页面，显示草稿列表（没写完）
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';

class DisplayDrafts extends StatefulWidget {
  const DisplayDrafts({super.key});

  @override
  State<DisplayDrafts> createState() => _DisplayDraftsState();
}

class _DisplayDraftsState extends State<DisplayDrafts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:AppBar(
        automaticallyImplyLeading: true,//返回按钮
      ),
      
      
      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Center(
            child: ListView.builder(
              itemCount: 3, 
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('草稿 ${index + 1}'),
                  onTap: () {
                    // 点击草稿后进入编辑界面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditDraftPage(draftIndex: index)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
