//新建草稿页面
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/widget/newitems.dart';

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
      ),

      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          // 返回按钮
          Positioned(
            top: 15,
            left: 9,
            child: AppBackButton(),
          ),
          
          //草稿箱（还没写）

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
            ],
          ),
          ],
      ),
    );
  }
}
