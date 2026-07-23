import 'package:flutter/material.dart';

class AddBatchScreen extends StatefulWidget {
  const AddBatchScreen({Key? key}) : super(key: key);

  @override
  _AddBatchScreenState createState() => _AddBatchScreenState();
}

class _AddBatchScreenState extends State<AddBatchScreen> {
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  DateTime? _selectedDate;
  
  // قائمة وهمية مؤقتة للأصناف لتجربة القائمة المنسدلة
  String _selectedItem = 'محلول ملحي (Normal Saline)';
  final List<String> _dummyItems = [
    'محلول ملحي (Normal Saline)',
    'خيوط جراحية',
    'مضاد حيوي (Amoxicillin)',
    'مسكن ألم (Paracetamol)'
  ];

  // دالة لفتح تقويم (Calendar) لاختيار تاريخ الانتهاء
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // لا يمكن اختيار تاريخ في الماضي
      lastDate: DateTime(2035),  // حد أقصى للتواريخ
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة دفعة جديدة', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green, // نفس لون الزر في لوحة التحكم
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                // 1. القائمة المنسدلة لاختيار الصنف
                DropdownButtonFormField<String>(
                  value: _selectedItem,
                  decoration: const InputDecoration(
                    labelText: 'اختر الصنف',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory),
                  ),
                  items: _dummyItems.map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // 2. حقل رقم التشغيلة (Batch Number)
                TextField(
                  controller: _batchController,
                  decoration: const InputDecoration(
                    labelText: 'رقم التشغيلة (Batch/Lot Number)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.qr_code),
                  ),
                ),
                const SizedBox(height: 20),

                // 3. حقل الكمية
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الكمية المدخلة',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.add_shopping_cart),
                  ),
                ),
                const SizedBox(height: 20),

                // 4. زر اختيار تاريخ الانتهاء (مهم جداً)
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'تاريخ الانتهاء غير محدد'
                            : 'الانتهاء: ${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}',
                        style: TextStyle(
                          fontSize: 16, 
                          color: _selectedDate == null ? Colors.red : Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('اختر التاريخ', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // 5. زر الحفظ
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    // إغلاق الشاشة والعودة للوحة التحكم مع رسالة نجاح
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم حفظ الدفعة في المخزون بنجاح!')),
                    );
                    Navigator.pop(context); 
                  },
                  child: const Text(
                    'حفظ الدفعة', 
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}