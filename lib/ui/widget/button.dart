import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';

//长长扁扁的按钮，choose的“新建”和“草稿箱”
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;

  CustomButton({required this.text, required this.onPressed, this.width = 389, this.height = 71,this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: primary1, 
        border: Border.all(color: primary2,width: 1), 
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

class EditButton extends CustomButton {
  EditButton({required VoidCallback onPressed})
      : super(text: '编辑', onPressed: onPressed, width: 60, height: 30,fontSize: 10);
}
