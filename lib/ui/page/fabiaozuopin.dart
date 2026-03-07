import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/net/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class Fabiaozuopin extends StatefulWidget {
  const Fabiaozuopin({super.key});

  @override
  State<Fabiaozuopin> createState() => _FabiaozuopinState();
}

class _FabiaozuopinState extends State<Fabiaozuopin> {
  final TextEditingController _contentController = TextEditingController();
  List<File> _selectedImages = [];
  bool _isPublishing = false;

  // 处理图片选择
  void _handleImagesSelected(List<File> images) {
    setState(() {
      _selectedImages = images;
    });
  }

  // 发布帖子
  Future<void> _publishPost() async {
    if (_contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请输入内容')),
      );
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    try {
      // 构建FormData用于同时发送文本和图片
      FormData formData = FormData.fromMap({
        "type": "post", // 帖子类型
        "title": "发表的帖子", // 暂时固定，实际可以让用户输入
        "content": _contentController.text,
      });

      // 添加图片文件
      for (int i = 0; i < _selectedImages.length; i++) {
        formData.files.add(MapEntry(
          'images[$i]',
          await MultipartFile.fromFile(_selectedImages[i].path, filename: 'image$i.jpg'),
        ));
      }

      // 调用API
      final response = await Http().post(
        path: '/square/publish',
        data: formData,
      );

      if (response.statusCode == 200) {
        final responseData = response.data is String ? json.decode(response.data) : response.data;
        if (responseData['code'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('发布成功')),
          );
          // 清空输入和图片
          _contentController.clear();
          setState(() {
            _selectedImages = [];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('发布失败: ${responseData['msg']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('发布失败，请稍后重试')),
        );
      }
    } catch (e) {
      print('发布失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('网络错误，请稍后重试')),
      );
    } finally {
      setState(() {
        _isPublishing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),

      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          // 返回按钮
          Positioned(
            top: 20,
            left: 9,
            child: AppBackButton(),
          ),
          
          //发表按钮
          Positioned(
            top: 15,
            right: 9,
            child: CustomButton(
              width: 60,
              height: 30,
              fontSize: 10,
              text: _isPublishing ? '发布中...' : '发表',
              onPressed: _isPublishing ? () {} : () { _publishPost(); },
            ),
          ),
          
          //粉色框框
          Positioned(
            top: 60,
            left:20,
            child: PostInput(
              controller: _contentController,
              onImagesSelected: _handleImagesSelected,
              initialImages: _selectedImages,
            ),
          ),
          ],
      ),
    );
  }
}

class PostInput extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function(List<File>)? onImagesSelected;
  final List<File>? initialImages;

  const PostInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onImagesSelected,
    this.initialImages,
  });

  @override
  _PostInputState createState() => _PostInputState();
}

class _PostInputState extends State<PostInput> {
  final TextEditingController _internalController = TextEditingController();
  TextEditingController get _controller => widget.controller ?? _internalController;
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialImages != null) {
      _images = widget.initialImages!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _updateImages(List<File> images) {
    setState(() {
      _images = images;
    });
    if (widget.onImagesSelected != null) {
      widget.onImagesSelected!(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: pinkGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,//长度包裹子组件
        children: [
          TextField(
            controller: _controller,
            maxLength: 200,
            maxLines: null,
            decoration: InputDecoration(
              hintText: '发表你的想法...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            ),
            onChanged: widget.onChanged,
          ),
          SizedBox(height: 16),
          PickImage(
            images: _images,
            onImagesChanged: _updateImages,
          ),
        ],
      ),
    );
  }
}