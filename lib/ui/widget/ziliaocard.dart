import 'package:flutter/material.dart';
import 'dart:io';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/service/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:we_pai/ui/page/wode.dart';

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

              //提交按钮
              SizedBox(height: 30),
              ElevatedButton(onPressed: _submitProfile, child: Text('提交资料')),
            ],
          ),
        ),
      ),
    );
  }

  //提交资料
  Future<void> _submitProfile() async {
    try {
      //收集输入信息
      Map<String, dynamic> profileData = {
        'nickname': _nicknameController.text,
        'sex': _genderController.text == '男' ? 1 : 0,
        'phone': _contactController.text,
      };

      //打印输入内容，用于调试
      print('提交的资料: $profileData');

      //发送网络请求
      await ApiService().updateUserProfile(profileData);

      //显示成功提示
      Fluttertoast.showToast(
        msg: '资料更新成功',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );

      //导航回个人主页
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wode()),
      );
    } catch (e) {
      //显示错误提示
      Fluttertoast.showToast(
        msg: '资料更新失败: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
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
  // final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _noticeController = TextEditingController();

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

              // //价格输入框
              // lineInput(controller: _priceController, labelText: '请输入你的价目表'),
              // Divider(color: primary3, height: 30, thickness: 1),

              // //约拍须知输入框
              // lineInput(controller: _noticeController, labelText: '请输入你的约拍须知'),

              //提交按钮
              SizedBox(height: 30),
              ElevatedButton(onPressed: _submitProfile, child: Text('提交资料')),
            ],
          ),
        ),
      ),
    );
  }

  //提交资料
  Future<void> _submitProfile() async {
    try {
      //收集输入信息
      Map<String, dynamic> profileData = {
        'nickname': _nicknameController.text,
        'sex': _genderController.text == '男' ? 1 : 0,
        'phone': _contactController.text,
        'detail': _introController.text,
        'photographer': {
          'style': _styleController.text
              .split(',')
              .map((s) => s.trim())
              .toList(),
          'equipment': _equipController.text
              .split(',')
              .map((s) => s.trim())
              .toList(),
          'type': [], // 可以根据需要添加类型输入
        },
      };

      //打印输入内容，用于调试
      print('提交的资料: $profileData');

      //发送网络请求
      await ApiService().updateUserProfile(profileData);

      //显示成功提示
      Fluttertoast.showToast(
        msg: '资料更新成功',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );

      //导航回个人主页
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wode()),
      );
    } catch (e) {
      //显示错误提示
      Fluttertoast.showToast(
        msg: '资料更新失败: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
