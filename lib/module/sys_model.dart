import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';

class SysModel {
  int total;
  List<SYSList> phoList;

  SysModel({required this.total, required this.phoList});

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(total: json['total'], phoList: json['list']);
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'phoList': phoList};
  }
}
