import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';

//长长扁扁的按钮，choose的“新建”和“草稿箱”，可以自己设置宽高，按钮名字
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

//编辑按钮
class EditButton extends CustomButton {
  EditButton({required VoidCallback onPressed})
      : super(text: '编辑', onPressed: onPressed, width: 70, height: 30,fontSize: 18);
}

//无边框，“提交”和“保存草稿”的模板
class BorderLessButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  BorderLessButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height:50,
      decoration: BoxDecoration(
        color: primary1, 
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
    Key? key,
    this.onTap,
    this.width = 15,
    this.height = 15,
    this.assetPath = 'lib/material/return.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
      ),
    );
  }
}

//问题反馈按钮
class ClassButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;

   ClassButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child:AnimatedContainer(//来点动画（）
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          
          width:100,
          height:35,

          decoration: BoxDecoration(
            color: qianhui, 
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: Colors.black, width: 2.0)
                : null, // 选中黑框，未选中时无边框
          ),

          child: Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

//提交，带边框和文字阴影效果
class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // --- 样式设置 ---
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
                    )
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