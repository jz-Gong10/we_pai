import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/widget/background.dart';

class Fabiaozuopin extends StatefulWidget {
  const Fabiaozuopin({super.key});

  @override
  State<Fabiaozuopin> createState() => _FabiaozuopinState();
}

class _FabiaozuopinState extends State<Fabiaozuopin> {
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
              text: '发表',
              onPressed: () {
                // 发表按钮点击事件，还没写
              },
            ),
          ),
          
          //粉色框框
          Positioned(
            top: 60,
            left:20,
            child: PostInput(),
          ),
          ],
      ),
    );
  }
}

class PostInput extends StatefulWidget {
  final TextEditingController? controller;
  // final String hintText;
  final ValueChanged<String>? onChanged;
  // final double width;

  const PostInput({
    super.key,
    this.controller,
    // this.hintText = '发表你的想法...',
    this.onChanged,
    // required this.width,
  });

  @override
  _PostInputState createState() => _PostInputState();
}

class _PostInputState extends State<PostInput> {
  final TextEditingController _internalController = TextEditingController();
  TextEditingController get _controller => widget.controller ?? _internalController;

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
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
          PickImage(),
        ],
      ),
    );
  }
}