class CategoryModel {
  final int? id;
  final String nameAr;
  final String nameEn;
  final String iconPath;

  CategoryModel({
    this.id,
    required this.nameAr,
    required this.nameEn,
    required this.iconPath,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
      iconPath: map['icon_path'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'icon_path': iconPath,
    };
  }
}