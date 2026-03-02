//显示草稿列表页面中，每个草稿的组件
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/page/editdraft.dart';
import 'package:we_pai/model/draft_model.dart';

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
                  SizedBox(height: 8),
                  Text(
                  '上次编辑：${_formatDate(widget.draft.createdAt)}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
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
              child: EditButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Editdraft(
                    //跳转时携带数据
                  )),
                );
              }),
            ),
          ),
        ],
      ),
      
    );
  }

  // 日期格式化处理（去除时间，只保留日期）
  String _formatDate(String dateTimeStr) {
    if (dateTimeStr.length >= 10) {
      return dateTimeStr.substring(0, 10);
    }
    return dateTimeStr;
  }
}