class KedanOrder {
  int paymentStatus;
  String shootTime;
  String createdAt;
  String remark;
  String contactInfo;
  String type;
  int photographerId;
  String customerName;
  String duration;
  int subjectCount;
  String customerAvatar;
  double price;
  bool needEquipment;
  String location;
  int customerId;
  int orderId;
  int status;

  KedanOrder({
    required this.paymentStatus,
    required this.shootTime,
    required this.createdAt,
    required this.remark,
    required this.contactInfo,
    required this.type,
    required this.photographerId,
    required this.customerName,
    required this.duration,
    required this.subjectCount,
    required this.customerAvatar,
    required this.price,
    required this.needEquipment,
    required this.location,
    required this.customerId,
    required this.orderId,
    required this.status,
  });

  factory KedanOrder.fromJson(Map<String, dynamic> json) {
    return KedanOrder(
      paymentStatus: json['payment_status'],
      shootTime: json['shoot_time'],
      createdAt: json['created_at'],
      remark: json['remark'],
      contactInfo: json['contact_info'],
      type: json['type'],
      photographerId: json['photographer_id'],
      customerName: json['customerName'],
      duration: json['duration'],
      subjectCount: json['subject_count'],
      customerAvatar: json['customerAvatar'],
      price: json['price'],
      needEquipment: json['need_equipment'],
      location: json['location'],
      customerId: json['customer_id'],
      orderId: json['order_id'],
      status: json['status'],
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
  int total;
  int pages;
  List<KedanOrder> list;

  KedanList({required this.total, required this.pages, required this.list});

  factory KedanList.fromJson(Map<String, dynamic> json) {
    return KedanList(
      total: json['total'],
      pages: json['pages'],
      list: List<KedanOrder>.from(
        json['list'].map((item) => KedanOrder.fromJson(item)),
      ),
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
