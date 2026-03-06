class KedanOrder {
  int? paymentStatus;
  String? shootTime;
  String? createdAt;
  String? remark;
  String? contactInfo;
  String? type;
  int? photographerId;
  String? customerName;
  String? duration;
  int? subjectCount;
  String? customerAvatar;
  double? price;
  bool? needEquipment;
  String? location;
  int? customerId;
  int? orderId;
  int? status;

  KedanOrder({
    this.paymentStatus,
    this.shootTime,
    this.createdAt,
    this.remark,
    this.contactInfo,
    this.type,
    this.photographerId,
    this.customerName,
    this.duration,
    this.subjectCount,
    this.customerAvatar,
    this.price,
    this.needEquipment,
    this.location,
    this.customerId,
    this.orderId,
    this.status,
  });

  factory KedanOrder.fromJson(Map<String, dynamic> json) {
    return KedanOrder(
      paymentStatus: json['payment_status'] is int
          ? json['payment_status']
          : int.tryParse(json['payment_status']?.toString() ?? '0'),
      shootTime: json['shoot_time']?.toString(),
      createdAt: json['created_at']?.toString(),
      remark: json['remark']?.toString(),
      contactInfo: json['contact_info']?.toString(),
      type: json['type']?.toString(),
      photographerId: json['photographer_id'] is int
          ? json['photographer_id']
          : int.tryParse(json['photographer_id']?.toString() ?? '0'),
      customerName: json['customerName']?.toString(),
      duration: json['duration']?.toString(),
      subjectCount: json['subject_count'] is int
          ? json['subject_count']
          : int.tryParse(json['subject_count']?.toString() ?? '0'),
      customerAvatar: json['customerAvatar']?.toString(),
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price']?.toString() ?? '0.0'),
      needEquipment: json['need_equipment'] is bool
          ? json['need_equipment']
          : false,
      location: json['location']?.toString(),
      customerId: json['customer_id'] is int
          ? json['customer_id']
          : int.tryParse(json['customer_id']?.toString() ?? '0'),
      orderId: json['order_id'] is int
          ? json['order_id']
          : int.tryParse(json['order_id']?.toString() ?? '0'),
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_status': paymentStatus,
      'shoot_time': shootTime,
      'created_at': createdAt,
      'remark': remark,
      'contact_info': contactInfo,
      'type': type,
      'photographer_id': photographerId,
      'customerName': customerName,
      'duration': duration,
      'subject_count': subjectCount,
      'customerAvatar': customerAvatar,
      'price': price,
      'need_equipment': needEquipment,
      'location': location,
      'customer_id': customerId,
      'order_id': orderId,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'KedanOrder{orderId: $orderId, type: $type, price: $price, status: $status}';
  }
}

// 订单列表数据模型
class KedanList {
  int? total;
  int? pages;
  List<KedanOrder> list;

  KedanList({this.total, this.pages, required this.list});

  factory KedanList.fromJson(Map<String, dynamic> json) {
    return KedanList(
      total: json['total'] is int
          ? json['total']
          : int.tryParse(json['total']?.toString() ?? '0'),
      pages: json['pages'] is int
          ? json['pages']
          : int.tryParse(json['pages']?.toString() ?? '0'),
      list: json['list'] != null
          ? List<KedanOrder>.from(
              json['list'].map((item) => KedanOrder.fromJson(item)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'pages': pages,
      'list': list.map((item) => item.toJson()).toList(),
    };
  }
}
