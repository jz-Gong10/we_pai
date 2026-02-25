import 'package:flutter/material.dart';
import 'package:we_pai/ui/themes/colors.dart';

//前面是模板 文本输入框5，带两行字的71，选择148
//含文本输入框的组件
class TextInputWidget extends StatefulWidget {
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;

  const TextInputWidget({
    Key? key,
    required this.label,
    this.hint = '点击输入',
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 32,left: 20,right: 20),
      width: 389,
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //标题
            widget.label,
            style: const TextStyle(
              fontFamily: 'ShanHaiJiGuMingKe',
              fontSize: 16, 
              color: Colors.black,
              ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            style: const TextStyle(
              //输入文本格式
              fontSize: 16, 
              color: Colors.black
              
              ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 16, 
                color: Colors.grey.shade700
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            ),
          ),
        ],
      ),
    );
  }
}

// TextInputWidget1：比TextInputWidget多了两行描述文本
class TextInputWidget1 extends TextInputWidget {
  final String line1;
  final String line2;
  final String hint;

  const TextInputWidget1({
    Key? key,
    required String label,
    ValueChanged<String>? onChanged,
    this.line1 = '类型：（任务写真/毕业照/活动记录/小动物/其他）',
    this.line2 = '风格：（清新/复古/氛围感/其他）',
    this.hint = '点击输入',
  }) : super(key: key, label: label, onChanged: onChanged);

  @override
  State<TextInputWidget1> createState() => _TextInputWidget1State();
}

class _TextInputWidget1State extends State<TextInputWidget1> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 32,left: 20,right: 20),
      width: 389,
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontFamily: 'ShanHaiJiGuMingKe', fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            widget.line1,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 4),
          Text(
            widget.line2,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 16, 
                color: Colors.grey.shade700
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            ),
          ),
        ],
      ),
    );
  }
}

//是/否选项组件
class YesNoWidget extends StatefulWidget {
  final String label;
  final bool? initialValue;
  final ValueChanged<bool>? onChanged;

  const YesNoWidget({
    Key? key,
    required this.label,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<YesNoWidget> createState() => _YesNoWidgetState();
}

class _YesNoWidgetState extends State<YesNoWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? false;
  }

  void _setValue(bool v) {
    if (_value == v) return;
    setState(() {
      _value = v;
    });
    widget.onChanged?.call(v);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 32, left: 20, right: 20),
      width: 389,
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontFamily: 'ShanHaiJiGuMingKe',fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 4),
          RadioListTile(value: true, groupValue: _value, onChanged: (v) => _setValue(true), title: const Text('是'),dense:true),
          RadioListTile(value: false, groupValue: _value, onChanged: (v) => _setValue(false), title: const Text('否'),dense:true),
        ],
      ),
    );
  }
}

//下面是具体的输入组件
//01 起始时间
class StartTimePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;

  const StartTimePicker({
    Key? key,
    this.initialDate,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StartTimePicker> createState() => _StartTimePickerState();
}

class _StartTimePickerState extends State<StartTimePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 50),
      lastDate: DateTime(now.year + 50),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onChanged?.call(picked);
    }
  }

  String _formatDate(DateTime d) {
    final y = d.year.toString();
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 32,left: 20,right: 20),
      width: 389,
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '01 起始时间',
              style: TextStyle(fontFamily: 'ShanHaiJiGuMingKe',fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(_selectedDate),
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
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

//02 大约拍摄时长
class DurationInputWidget extends TextInputWidget {
  const DurationInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '02 大约拍摄时长',
          hint: '点击输入（小时）',
          onChanged: onChanged,
        );
}

//03 地点
class LocationInputWidget extends TextInputWidget {
  const LocationInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '03 地点',
          onChanged: onChanged,
        );
}

//04 拍摄人数
class PeopleInputWidget extends TextInputWidget {
  const PeopleInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '04 拍摄人数',
          onChanged: onChanged,
        );
}

//05 报酬
class RewardInputWidget extends TextInputWidget {
  const RewardInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '05 报酬',
          onChanged: onChanged,
        );
}

//06 是否需要专业设备
class EquipmentInputWidget extends YesNoWidget {
  const EquipmentInputWidget({
    Key? key,
    ValueChanged<bool>? onChanged,
  }) : super(
          key: key,
          label: '06 是否需要专业设备',
          onChanged: onChanged,
        );
}

//07 拍摄类型与风格
class StyleInputWidget extends TextInputWidget1 {
  const StyleInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '07 拍摄类型与风格',
          onChanged: onChanged,
        );
}

//08 联系方式
class ContactInputWidget extends TextInputWidget {
  const ContactInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '08 联系方式（微信/QQ/电话号码）',
          onChanged: onChanged,
        );
}

//09 是否预约特定摄影师
class PhotographerInputWidget extends YesNoWidget {
  const PhotographerInputWidget({
    Key? key,
    ValueChanged<bool>? onChanged,
  }) : super(
          key: key,
          label: '09 是否预约特定摄影师',
          onChanged: onChanged,
        );
}

//10 其他问题与需求
class OtherInputWidget extends TextInputWidget {
  const OtherInputWidget({
    Key? key,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          label: '10 其他问题与需求',
          onChanged: onChanged,
        );
}

