import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

//长长扁扁的按钮，choose的“新建”和“草稿箱”，可以自己设置宽高，按钮名字,字号
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 389,
    this.height = 71,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        //渐变
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primary1, primary2],
        ),

        border: Border.all(color: primary3, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//编辑按钮
class EditButton extends CustomButton {
  EditButton({required super.onPressed})
    : super(text: '编辑', width: 100, height: 40, fontSize: 14);
}

//无边框，“提交”和“保存草稿”的模板
class BorderLessButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BorderLessButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'ShanHaiJiGuMingKe',
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

//返回按钮，返回上一个页面
class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double width;
  final double height;
  final String assetPath;

  const AppBackButton({
    super.key,
    this.onTap,
    this.width = 30,
    this.height = 30,
    this.assetPath = 'lib/material/return.png',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context), //默认返回上一个页面
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

//问题反馈按钮
class ClassButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;

  const ClassButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: AnimatedContainer(
          //来点动画（）
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          width: 100,
          height: 35,

          decoration: BoxDecoration(
            color: qianhui,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: Colors.black, width: 2.0)
                : null, // 选中黑框，未选中时无边框
          ),

          child: Text(
            text,
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

//提交，带边框和文字阴影效果
class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 60,
      decoration: BoxDecoration(
        color: primary2,

        //边框阴影
        boxShadow: [
          BoxShadow(
            color: primary3,
            blurRadius: 8, //模糊半径
            offset: Offset(0, 4), //偏移量(x, y)，向下偏移产生投影
          ),
        ],

        borderRadius: BorderRadius.circular(30), // 大圆角
      ),

      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, //去除默认内边距
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: Stack(
          children: [
            //按钮文字
            Center(
              child: Text(
                '提交',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  //文字阴影
                  shadows: [
                    Shadow(
                      blurRadius: 3.0,
                      color: Colors.grey,
                      offset: Offset(0, 2), // 文字阴影偏移
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//图片选择器（最多九张）
class PickImage extends StatefulWidget {
  final List<File>? images;
  final Function(List<File>)? onImagesChanged;

  const PickImage({super.key, this.images, this.onImagesChanged});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  //用于存储选择的图片文件
  late List<File> _images;

  //图片选择器
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _images = widget.images ?? [];
  }

  @override
  void didUpdateWidget(PickImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.images != null && widget.images != oldWidget.images) {
      setState(() {
        _images = widget.images!;
      });
    }
  }

  //选择图片方法
  Future<void> _pickImage() async {
    //如果图片数量已经达到九张，直接提示并返回
    if (_images.length >= 9) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('最多只能上传 9 张图片')));
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
                leading: Icon(Icons.photo_library),
                title: const Text('从相册选择'),

                onTap: () async {
                  Navigator.pop(context); // 关闭菜单
                  final List<XFile> images = await _picker.pickMultiImage();
                  if (images != null && images.isNotEmpty) {
                    //存在并且包含内容
                    // 仅添加不超过上限9的图片
                    final int available = 9 - _images.length;
                    final List<File> toAdd = images
                        .take(available)
                        .map((xFile) => File(xFile.path))
                        .toList();
                    if (toAdd.isNotEmpty) {
                      setState(() {
                        _images.addAll(toAdd);
                      });
                      if (widget.onImagesChanged != null) {
                        widget.onImagesChanged!(_images);
                      }
                    }
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: const Text('拍照'),

                onTap: () async {
                  Navigator.pop(context); // 关闭菜单
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null && _images.length < 9) {
                    setState(() {
                      _images.add(File(image.path));
                    });
                    if (widget.onImagesChanged != null) {
                      widget.onImagesChanged!(_images);
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //删除指定位置的图片
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    if (widget.onImagesChanged != null) {
      widget.onImagesChanged!(_images);
    }
  }

  //有图片显示缩略图，没满九张有加号
  @override
  Widget build(BuildContext context) {
    return Wrap(
      //使用wrap包裹图片，自动换行
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
              ),
            ],
          );
        }),

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
    );
  }
}

//单张图片选择器
class PickSingleImage extends StatefulWidget {
  final Function(File?) onImageSelected;

  const PickSingleImage({super.key, required this.onImageSelected});

  @override
  State<PickSingleImage> createState() => _PickSingleImageState();
}

class _PickSingleImageState extends State<PickSingleImage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: const Text('从相册选择'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      _image = File(image.path);
                    });
                    widget.onImageSelected(_image);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: const Text('拍照'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    setState(() {
                      _image = File(image.path);
                    });
                    widget.onImageSelected(_image);
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: qianhui,
          image: _image != null
              ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover)
              : null,
        ),
        alignment: Alignment.center,
        child: _image == null
            ? Icon(Icons.add_a_photo, size: 30, color: Colors.black)
            : null,
      ),
    );
  }
}
