import 'package:flutter/material.dart';
import 'dart:io';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

//这里先写个带横线的文本输入框
class lineInput extends StatelessWidget {
  // 可以自定义controller和labelText
  final TextEditingController? controller;
  final String? labelText;

  const lineInput({super.key, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const UnderlineInputBorder(),
        labelStyle: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}

//这个是客户端的完善资料
class Ziliaocard extends StatefulWidget {
  const Ziliaocard({super.key});

  @override
  State<Ziliaocard> createState() => _ZiliaocardState();
}

class _ZiliaocardState extends State<Ziliaocard> {
  File? _image; //用户选择的图片会存储字_image中

  //文本输入框控制器
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      //大的容器
      margin: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 40,

      decoration: BoxDecoration(
        //渐变
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primary1, primary2],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary3, width: 1),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //头像行
              Row(
                children: [
                  //选择头像文本
                  Text(
                    '选择头像',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),

                  Spacer(), //占据中间空间

                  PickSingleImage(
                    onImageSelected: (File? image) {
                      setState(() {
                        _image = image;
                      });
                    },
                  ),
                ],
              ),

              //分割线
              Divider(color: primary3, height: 30, thickness: 1),
              //昵称输入框
              lineInput(controller: _nicknameController, labelText: '请输入你的昵称'),
              //分割线
              Divider(color: primary3, height: 30, thickness: 1),
              //性别输入框
              lineInput(controller: _genderController, labelText: '请输入你的性别'),
              //分割线
              Divider(color: primary3, height: 30, thickness: 1),
              //联系方式输入框
              lineInput(controller: _contactController, labelText: '请输入你的联系方式'),
            ],
          ),
        ),
      ),
    );
  }
}

//这个是摄影师端的完善资料
class Ziliaocard1 extends StatefulWidget {
  const Ziliaocard1({super.key});

  @override
  State<Ziliaocard1> createState() => _Ziliaocard1State();
}

class _Ziliaocard1State extends State<Ziliaocard1> {
  File? _image;

  //文本输入框控制器
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _introController = TextEditingController();
  final TextEditingController _equipController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noticeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      //大的容器
      margin: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 40,

      decoration: BoxDecoration(
        //渐变
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primary1, primary2],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary3, width: 1),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //头像行
              Row(
                children: [
                  //选择头像文本
                  Text(
                    '选择头像',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),

                  Spacer(), //占据中间空间

                  PickSingleImage(
                    onImageSelected: (File? image) {
                      setState(() {
                        _image = image;
                      });
                    },
                  ),
                ],
              ),

              //分割线
              Divider(color: primary3, height: 30, thickness: 1),
              //昵称输入框
              lineInput(controller: _nicknameController, labelText: '请输入你的昵称'),
              Divider(color: primary3, height: 30, thickness: 1),

              //性别输入框
              lineInput(controller: _genderController, labelText: '请输入你的性别'),
              Divider(color: primary3, height: 30, thickness: 1),

              //联系方式输入框
              lineInput(controller: _contactController, labelText: '请输入你的联系方式'),
              Divider(color: primary3, height: 30, thickness: 1),

              //个人简介输入框
              lineInput(controller: _introController, labelText: '请输入你的个人介绍'),
              Divider(color: primary3, height: 30, thickness: 1),

              //设备输入框
              lineInput(controller: _equipController, labelText: '请输入你的设备'),
              Divider(color: primary3, height: 30, thickness: 1),

              //风格输入框
              lineInput(controller: _styleController, labelText: '请输入你擅长的风格'),
              Divider(color: primary3, height: 30, thickness: 1),

              //价格输入框
              lineInput(controller: _priceController, labelText: '请输入你的价目表'),
              Divider(color: primary3, height: 30, thickness: 1),

              //约拍须知输入框
              lineInput(controller: _noticeController, labelText: '请输入你的约拍须知'),
              //
            ],
          ),
        ),
      ),
    );
  }
}
