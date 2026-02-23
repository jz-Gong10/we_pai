import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:we_pai/ui/themes/colors.dart';

class Ziliaocard extends StatefulWidget {
  const Ziliaocard({super.key});

  @override
  State<Ziliaocard> createState() => _ZiliaocardState();
}

class _ZiliaocardState extends State<Ziliaocard>{
  //用于存储选择的图片文件
  File? _image;

  //文本输入框控制器
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  //图片选择器
  final ImagePicker _picker = ImagePicker();

  //选择图片
  Future<void> _pickImage() async{
    //弹出底部选择菜单，从相册选择或者拍照
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context) {
        return SafeArea(
          
          child: Wrap(
            children: [
              ListTile(
                leading:Icon(Icons.photo_library),
                title: const Text('从相册选择'),

                onTap: () async {
                  Navigator.pop(context); // 关闭菜单
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _image = File(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading:Icon(Icons.photo_camera), 
                title: const Text('拍照'),
                
                onTap: () async {
                  Navigator.pop(context); // 关闭菜单
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _image = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
      //大的容器
      margin:EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 40,
      
      decoration:BoxDecoration(
        //渐变
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          colors: [
            primary1,
            primary2,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primary3, 
          width: 1,
        ),
      ),

      child:SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(16),
          child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //头像行
          Row(
            children: [
              //选择头像文本
              Text(
                '选择头像',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600, 
                ),
              ),

              Spacer(),//占据中间空间

              //点击按钮触发选择图片
              GestureDetector(
                onTap: _pickImage, 
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[350],
                    //如有有图片就显示
                    image: _image != null ? DecorationImage(image: FileImage(_image!),fit:BoxFit.cover) : null,
                  ),
                  alignment:Alignment.center,
                  //如果没图片就加号
                  child: _image == null ? Icon(Icons.add_a_photo, size: 30, color: Colors.black) : null,
                ),
              ),
              
            ],
          ),

          //分割线
          Divider(color:primary3,height:30,thickness: 1,),

          //昵称输入框
          TextField(
            controller: _nicknameController,
            decoration: InputDecoration(
              labelText: '请输入你的昵称',
              labelStyle: TextStyle(color: Colors.grey.shade600),
            ),
          ),

          //分割线
          Divider(color:primary3,height:30,thickness: 1,),

          //性别输入框
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                labelText: '请输入你的性别',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),

            //分割线
          Divider(color:primary3,height:30,thickness: 1,),

          //联系方式输入框
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: '请输入你的联系方式',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
        ),
      ),
      
    );
  }
}
