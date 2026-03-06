class Order {
  bool? isMyOrderAsCustomer;
  String? targetName;
  int? paymentStatus;
  String? shootTime;
  String? createdAt;
  String? remark;
  String? contactInfo;
  String? type;
  int? photographerId;
  String? targetAvatar;
  String? duration;
  int? subjectCount;
  double? price;
  bool? needEquipment;
  String? location;
  int? customerId;
  int? orderId;
  int? status;

  Order({
    this.isMyOrderAsCustomer,
    this.targetName,
    this.paymentStatus,
    this.shootTime,
    this.createdAt,
    this.remark,
    this.contactInfo,
    this.type,
    this.photographerId,
    this.targetAvatar,
    this.duration,
    this.subjectCount,
    this.price,
    this.needEquipment,
    this.location,
    this.customerId,
    this.orderId,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      isMyOrderAsCustomer: json['isMyOrderAsCustomer'],
      targetName: json['targetName']?.toString(),
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
      targetAvatar: json['targetAvatar']?.toString(),
      duration: json['duration']?.toString(),
      subjectCount: json['subject_count'] is int
          ? json['subject_count']
          : int.tryParse(json['subject_count']?.toString() ?? '0'),
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price']?.toString() ?? '0.0'),
      needEquipment: json['need_equipment'],
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
      'isMyOrderAsCustomer': isMyOrderAsCustomer,
      'targetName': targetName,
      'payment_status': paymentStatus,
      'shoot_time': shootTime,
      'created_at': createdAt,
      'remark': remark,
      'contact_info': contactInfo,
      'type': type,
      'photographer_id': photographerId,
      'targetAvatar': targetAvatar,
      'duration': duration,
      'subject_count': subjectCount,
      'price': price,
      'need_equipment': needEquipment,
      'location': location,
      'customer_id': customerId,
      'order_id': orderId,
      'status': status,
    };
  }
}

class OrderResponse {
  int? code;
  OrderData? data;

  OrderResponse({this.code, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      code: json['code'] is int
          ? json['code']
          : int.tryParse(json['code']?.toString() ?? '0'),
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'data': data?.toJson()};
  }
}

class OrderData {
  int? total;
  int? pages;
  List<Order>? list;

  OrderData({this.total, this.pages, this.list});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      total: json['total'] is int
          ? json['total']
          : int.tryParse(json['total']?.toString() ?? '0'),
      pages: json['pages'] is int
          ? json['pages']
          : int.tryParse(json['pages']?.toString() ?? '0'),
      list: json['list'] != null
          ? List<Order>.from(json['list'].map((item) => Order.fromJson(item)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'pages': pages,
      'list': list?.map((item) => item.toJson()).toList(),
    };
  }
}
