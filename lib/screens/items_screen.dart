import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  // قائمة وهمية لتخزين الأصناف مؤقتاً في ذاكرة التطبيق
  List<String> items = [];

  // Controller لأخذ النص من حقل الإدخال
  final TextEditingController _itemController = TextEditingController();

  // دالة لفتح نافذة إضافة صنف جديد
  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('إضافة صنف جديد'),
          content: TextField(
            controller: _itemController,
            decoration: const InputDecoration(
              hintText: "اسم الصنف (مثال: محاليل وريدية)",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _itemController.clear();
                Navigator.pop(context); // إغلاق النافذة بدون إضافة
              },
              child: const Text('إلغاء', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                if (_itemController.text.isNotEmpty) {
                  setState(() {
                    items.add(_itemController.text); // إضافة النص للقائمة
                  });
                  _itemController.clear();
                  Navigator.pop(context); // إغلاق النافذة بعد الإضافة
                }
              },
              child: const Text('إضافة', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأصناف والفئات', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      // تقييد العرض ليتناسب مع شكل الهاتف إذا كنت تستخدم الكمبيوتر
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد أصناف حتى الآن.\nاضغط على الزر أدناه لإضافة صنف.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.inventory_2, color: Colors.white),
                        ),
                        title: Text(
                          items[index],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              items.removeAt(index); // حذف الصنف عند الضغط على سلة المهملات
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}