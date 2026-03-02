//编辑草稿页面（在尝试能不能新建和编辑都在一起）
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/widget/newitems.dart';
import 'package:we_pai/ui/widget/tanchuang.dart';
import 'package:we_pai/api/api_service.dart';
import 'drafts.dart';
import 'package:we_pai/model/draft_model.dart';

class Newdraft extends StatefulWidget {
  final DraftModel? draft;

  const Newdraft({super.key, this.draft});
  @override
  State<Newdraft> createState() => _NewdraftState();
}

class _NewdraftState extends State<Newdraft> {
  // 表单状态字段
  DateTime _shootTime = DateTime.now();
  String _duration = '';
  String _location = '';
  int _subjectCount = 1;
  double _price = 0;
  bool _needEquipment = false;
  String _contactInfo = '';
  bool _wantPhotographer = false;
  final String _photographerId = '';
  String _type = '';
  String _remark = '';

  @override
  void initState() {
    super.initState();
    final d = widget.draft;
    if (d != null) {
      _location = d.location;
      final parsed = DateTime.tryParse(d.createdAt);
      if (parsed != null) _shootTime = parsed;
    }
  }

  //格式化时间
  String _formatDateTime(DateTime d) {
    final y = d.year.toString();
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final h = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0'); 
     return '$y-$m-$day $h:$min:00'; 
  }

  //提交实现逻辑
  Future<void> _handleSubmit() async {
    final payload = {
      'photographerId': _wantPhotographer ? _photographerId : '',
      'type': _type,
      'shootTime': _formatDateTime(_shootTime),
      'duration': _duration,
      'location': _location,
      'subjectCount': _subjectCount,
      'price': _price,
      'needEquipment': _needEquipment,
      'contactInfo': _contactInfo,
      'remark': _remark,
    };

    try {
      await ApiPost.createOrder(payload);
      await SuccessPostWidget.show(context, text: '提交成功', duration: const Duration(seconds: 2));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('提交失败：$e')));
    }
  }

  //保存实现逻辑
  Future<void> _handleSaveDraft() async {
    final payload = {
      'photographerId': _wantPhotographer ? _photographerId : '',
      'type': _type,
      'shootTime': _formatDateTime(_shootTime),
      'duration': _duration,
      'location': _location,
      'subjectCount': _subjectCount,
      'price': _price,
      'needEquipment': _needEquipment,
      'contactInfo': _contactInfo,
      'remark': _remark,
      'isDraft': true,
    };

    try {
      await ApiSave.saveOrder(payload);
      await SuccessSaveDraftWidget.show(context, text: '保存草稿成功', duration: const Duration(seconds: 2));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('保存草稿失败：$e')));
    }
  }

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
              StartTimePicker(initialDate: _shootTime, onChanged: (d) => setState(() => _shootTime = d)),
              DurationInputWidget(onChanged: (v) => setState(() => _duration = v)),
              LocationInputWidget(onChanged: (v) => setState(() => _location = v)),
              PeopleInputWidget(onChanged: (v) {
                final n = int.tryParse(v) ?? 1;
                setState(() => _subjectCount = n);
              }),
              RewardInputWidget(onChanged: (v) {
                final p = double.tryParse(v) ?? 0;
                setState(() => _price = p);
              }),
              EquipmentInputWidget(onChanged: (b) => setState(() => _needEquipment = b)),
              StyleInputWidget(onChanged: (v) => setState(() => _type = v)),
              ContactInputWidget(onChanged: (v) => setState(() => _contactInfo = v)),
              PhotographerInputWidget(onChanged: (b) => setState(() => _wantPhotographer = b)),
              OtherInputWidget(onChanged: (v) => setState(() => _remark = v)),
              SizedBox(height: 50), 
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BorderLessButton(
                    text: '提交',
                    onPressed: () async {
                      await _handleSubmit();
                    },
                  ),
                  SizedBox(width: 50), 
                  BorderLessButton(
                    text: '保存草稿',
                    onPressed: () async {
                      await _handleSaveDraft();
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
