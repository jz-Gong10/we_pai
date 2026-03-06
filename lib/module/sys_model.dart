import 'package:we_pai/module/recieve_sheyinghsiliebiao.dart';

class SysModel {
  int? total;
  List<SYSList> phoList;

  SysModel({this.total, required this.phoList});

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      total: json['total'] is int
          ? json['total']
          : int.tryParse(json['total']?.toString() ?? '0'),
      phoList: json['list'] != null
          ? List<SYSList>.from(
              json['list'].map((item) => SYSList.fromJson(item)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'phoList': phoList};
  }
}
