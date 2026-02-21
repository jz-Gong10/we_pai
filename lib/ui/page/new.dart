//新建草稿页面
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/widget/newitems.dart';
import 'package:we_pai/ui/widget/tanchuang.dart';
import 'drafts.dart';

class Newdraft extends StatefulWidget {
  const Newdraft({super.key});

  @override
  State<Newdraft> createState() => _NewdraftState();
}

class _NewdraftState extends State<Newdraft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 9),
          child: AppBackButton(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: const Icon(Icons.drafts_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DisplayDrafts()),
                );
              },
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),
          
          //草稿编辑项
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              StartTimePicker(),
              DurationInputWidget(),
              LocationInputWidget(),
              PeopleInputWidget(),
              RewardInputWidget(),
              EquipmentInputWidget(),
              StyleInputWidget(),
              ContactInputWidget(),
              PhotographerInputWidget(),
              OtherInputWidget(),
              SizedBox(height: 50), 
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BorderLessButton(
                    text: '提交',
                    onPressed: () {
                      // TODO: 在此处添加实际提交逻辑
                      SuccessPostWidget.show(context, text: '提交成功', duration: const Duration(seconds: 2));
                    },
                  ),
                  SizedBox(width: 50), 
                  BorderLessButton(
                    text: '保存草稿',
                    onPressed: () {
                      // TODO: 在此处添加实际保存草稿逻辑
                      SuccessSaveDraftWidget.show(context, text: '保存草稿成功', duration: const Duration(seconds: 2));
                    },
                  ),
                  
                ],
              ),
            ],
          ),
          ],
      ),
    );
  }
}
