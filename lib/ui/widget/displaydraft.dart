//显示草稿列表页面中，每个草稿的组件
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/model/draft_model.dart';
import 'package:we_pai/ui/page/new.dart';
import 'package:we_pai/api/api_service.dart';

class Displaydraft extends StatefulWidget {
  //接收传递过来的草稿数据
  final DraftModel draft;
  const Displaydraft({super.key, required this.draft});

  @override
  State<Displaydraft> createState() => _DisplaydraftState();
}

class _DisplaydraftState extends State<Displaydraft> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 45, horizontal: 26),
      width: 389,
      height: 158,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          colors: [
            primary1, 
            primary2, 
          ],
        ), 
        border: Border.all(color: primary2,width: 1), 
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,bottom:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '拍摄地点：${widget.draft.location}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )
                  ),
                ],
              ),
            ),
            ),
          

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: EditButton(onPressed: () async {//编辑按钮
                try {
                  // 获取草稿详细信息
                  final response = await ApiDetail.fetchDraftDetail(widget.draft.orderId!);
                  if (response.code == 200 && response.data != null) {
                    // 将详细信息传递给Newdraft页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Newdraft(
                        draft: widget.draft,
                      )),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('获取草稿详情失败: ${response.msg}')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('获取草稿详情失败: $e')),
                  );
                }
              }),
            ),
          ),
        ],
      ),
      
    );
  }


}