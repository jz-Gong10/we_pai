import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';

//长长扁扁的按钮，choose的“新建”和“草稿箱”
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  CustomButton({required this.text, required this.onPressed, this.width = 350, this.height = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: primary1, 
        border: Border.all(color: primary2), 
        borderRadius: BorderRadius.circular(12), 
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class EditButton extends CustomButton {
  EditButton({required String text, required VoidCallback onPressed})
      : super(text: '编辑', onPressed: onPressed, width: 60, height: 50);
}
