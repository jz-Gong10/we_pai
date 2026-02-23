import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/page/fankuichenggong.dart';

class Problems extends StatefulWidget {
  const Problems({super.key});

  @override
  State<Problems> createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems>{
  //用于存储选择的图片文件
  List<File> _images = [];

  //具体问题描述文本输入框控制器
  final TextEditingController _detailController = TextEditingController();
  
  //图片选择器
  final ImagePicker _picker = ImagePicker();

  //选择图片方法
  Future<void> _pickImage() async{
    //如果图片数量已经达到九张，直接提示并返回
    if (_images.length >= 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('最多只能上传 9 张图片')),
      );
      return;
    }

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
                  final List<XFile>? images = await _picker.pickMultiImage();
                  if (images != null && images.isNotEmpty) {
                    // 仅添加不超过上限9的图片
                    final int available = 9 - _images.length;
                    final List<File> toAdd = images.take(available).map((xFile) => File(xFile.path)).toList();
                    if (toAdd.isNotEmpty) {
                      setState(() {
                        _images.addAll(toAdd);
                      });
                    }
                  }
                },
              ),
              ListTile(
                leading:Icon(Icons.photo_camera), 
                title: const Text('拍照'),
                
                onTap: () async {
                  Navigator.pop(context); // 关闭菜单
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null && _images.length < 9) {
                    setState(() {
                      _images.add(File(image.path));
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
   // 删除指定位置的图片
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  //存储当前选中的问题类型
  String? _selectedProblemType;

  //问题类型列表
  final List<String> problemTypes = [
    '功能建议',
    '操作体验',
    '卡顿/闪退',
    '其他反馈',
  ];

  //释放控制器资源
  void dispose(){
    _detailController.dispose();
    super.dispose();
  }

  //页面设计
  @override
  Widget build(BuildContext context){
    return Container(
      
      margin:EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 40,

      child:SingleChildScrollView(//滚动（防止键盘遮挡）
        child:Padding(
          padding: EdgeInsets.all(16),
          child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //问题类型板块
          Text(
            '问题类型',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black, 
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          //两行两列按钮
           Wrap(
              spacing: 30,//水平间距
              runSpacing: 10,//垂直间距
              children: problemTypes.map((type) {
                return ClassButton(
                  text: type,
                  isSelected: _selectedProblemType == type,//单选
                  onTap: () {
                    setState(() {
                      _selectedProblemType = type;
                    });
                  },
                );
              }).toList(),
            ),

          SizedBox(height: 30),

          //具体问题描述板块
          Text(
              '具体问题描述',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
              controller: _detailController,
              maxLines: 4,
              maxLength: 200,
              decoration: InputDecoration(
                fillColor:qianhui,
                filled:true,
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: '请描述具体问题',
                hintStyle: TextStyle(fontSize: 12),
                 // flutter自动提示字数
              ),
            ),

          SizedBox(height: 20),

          //图片说明板块
          Text(
              '图片说明',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 20),
          //使用 Wrap 来展示图片，可以自动换行
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              //遍历 _images 列表，生成缩略图
              ..._images.map((file) {
                return Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(file),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //右上角的删除按钮
                    Positioned(
                      right: -5,
                      top: -5,
                      child: GestureDetector(
                        onTap: () {
                          //获取当前图片的索引并删除
                          _removeImage(_images.indexOf(file));
                        },
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close, size: 12, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              }).toList(),

              //添加“上传”按钮 (只有数量小于9时才显示)
              if (_images.length < 9)
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: qianhui,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.add_a_photo, size: 30, color: Colors.black),
                  ),
                ),
              ],
            ),

            // 提示文字
            if (_images.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '已选 ${_images.length}/9 张',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            
            SizedBox(height:30),

            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                SubmitButton(onPressed: () {
                  if (_selectedProblemType == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('请选择问题类型')),
                    );
                    return;
                  }
                  if (_detailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('请描述具体问题')),
                    );
                    return;
                  }
                  //数据提交逻辑待补充，这里只写了页面跳转
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Fankui()));
                }),
              ],)
            ],
          ),
          
        ),
      ),
    );
  }
}