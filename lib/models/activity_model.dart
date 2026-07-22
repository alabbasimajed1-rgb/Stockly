class ActivityModel {
  final int? id;
  final String transactionType; // نوع الحركة: إضافة، سحب، تعديل، إلخ
  final int itemId; // رقم الصنف الذي تمت عليه الحركة
  final double quantityChanged; // الكمية (بالموجب للإضافة وبالسالب للسحب)
  final String transactionDate; // تاريخ ووقت إتمام الحركة بدقة
  final String? note; // ملاحظات (مثلاً: تسجيل سبب تعديل خطأ الإدخال)

  ActivityModel({
    this.id,
    required this.transactionType,
    required this.itemId,
    required this.quantityChanged,
    required this.transactionDate,
    this.note,
  });

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'],
      transactionType: map['transaction_type'],
      itemId: map['item_id'],
      quantityChanged: map['quantity_changed'],
      transactionDate: map['transaction_date'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_type': transactionType,
      'item_id': itemId,
      'quantity_changed': quantityChanged,
      'transaction_date': transactionDate,
      'note': note,
    };
  }
}