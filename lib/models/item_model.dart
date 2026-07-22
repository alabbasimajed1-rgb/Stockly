class ItemModel {
  final int? id;
  final int categoryId; // لربط الصنف بالفئة التابع لها
  final String nameAr;
  final String nameEn;
  final String barcode;
  final String? imagePath; // قد لا يحتوي الصنف على صورة، لذا جعلناها اختيارية
  final int minQtyAlert;
  final int expiryMonthsAlert;

  ItemModel({
    this.id,
    required this.categoryId,
    required this.nameAr,
    required this.nameEn,
    required this.barcode,
    this.imagePath,
    required this.minQtyAlert,
    required this.expiryMonthsAlert,
  });

  // لتحويل البيانات القادمة من قاعدة البيانات إلى كائن برمجي
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      categoryId: map['category_id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
      barcode: map['barcode'],
      imagePath: map['image_path'],
      minQtyAlert: map['min_qty_alert'],
      expiryMonthsAlert: map['expiry_months_alert'],
    );
  }

  // لتحويل الكائن البرمجي إلى نص لحفظه في قاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'name_ar': nameAr,
      'name_en': nameEn,
      'barcode': barcode,
      'image_path': imagePath,
      'min_qty_alert': minQtyAlert,
      'expiry_months_alert': expiryMonthsAlert,
    };
  }
}