class BatchModel {
  final int? id;
  final int itemId; // لربط الدفعة بالصنف التابعة له
  final double quantity; // الكمية المتوفرة في هذه الدفعة فقط
  final String expireDate; // تاريخ انتهاء هذه الدفعة
  final int isActive; // 1 تعني نشط، 0 تعني انتهت الكمية ولا تظهر بالسحب

  BatchModel({
    this.id,
    required this.itemId,
    required this.quantity,
    required this.expireDate,
    this.isActive = 1,
  });

  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      id: map['id'],
      itemId: map['item_id'],
      quantity: map['quantity'],
      expireDate: map['expire_date'],
      isActive: map['is_active'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_id': itemId,
      'quantity': quantity,
      'expire_date': expireDate,
      'is_active': isActive,
    };
  }
}