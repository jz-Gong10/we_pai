import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';

//提交成功
class SuccessPostWidget extends StatelessWidget {
  final String text;
  const SuccessPostWidget({Key? key, this.text = "提交成功"}) : super(key: key);

  /// 显示提交成功弹窗，并在 [duration] 后自动关闭。
  static Future<void> show(BuildContext context,
      {String text = '提交成功', Duration duration = const Duration(seconds: 2)}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Center(child: SuccessPostWidget(text: text)),
    );

    await Future.delayed(duration);
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 231,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, 
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),

        //渐变
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          colors: [
            qianlan, 
            qianhuang, 
          ],
        ),
      ),
      
      child: Center(
        child: Text(
          '$text！',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
      ),
    );
  }
}

//保存草稿成功
class SuccessSaveDraftWidget extends SuccessPostWidget {
  SuccessSaveDraftWidget({String text = '保存草稿成功'}) : super(text: text);

  //2秒后自动关闭。
  static Future<void> show(BuildContext context,
      {String text = '保存草稿成功', Duration duration = const Duration(seconds: 2)}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Center(child: SuccessSaveDraftWidget(text: text)),
    );

    await Future.delayed(duration);
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }
}