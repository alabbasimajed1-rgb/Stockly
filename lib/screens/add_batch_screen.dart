import 'package:flutter/material.dart';
import '../localization.dart';

class AddBatchScreen extends StatefulWidget {
  const AddBatchScreen({Key? key}) : super(key: key);
  @override
  _AddBatchScreenState createState() => _AddBatchScreenState();
}

class _AddBatchScreenState extends State<AddBatchScreen> {
  String? _selectedItem;
  DateTime? _expiryDate;

  final List<String> _dummyItems = [
    'محلول ملحي (Normal Saline)', 'خيوط جراحية', 'مضاد حيوي (Amoxicillin)', 'مسكن ألم (Paracetamol)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.get('add_batch'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // القائمة المنسدلة لا تقبل إضافة أصناف جديدة، بل الاختيار فقط
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppTexts.get('select_item'),
                    prefixIcon: const Icon(Icons.inventory_2_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  value: _selectedItem,
                  items: _dummyItems.map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedItem = value),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppTexts.get('batch_number'),
                    prefixIcon: const Icon(Icons.qr_code),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppTexts.get('quantity'),
                    prefixIcon: const Icon(Icons.add_shopping_cart),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _expiryDate == null 
                            ? AppTexts.get('no_date_selected') 
                            : '${_expiryDate!.year}/${_expiryDate!.month}/${_expiryDate!.day}',
                        style: TextStyle(fontSize: 16, color: _expiryDate == null ? Colors.red : Colors.black),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today),
                        label: Text(AppTexts.get('select_date')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // الحقل الجديد: تنبيه الحد الأدنى للكمية
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppTexts.get('min_qty_alert'),
                    prefixIcon: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                
                // الحقل الجديد: تنبيه قرب الانتهاء (بالأشهر)
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppTexts.get('min_expiry_alert'),
                    prefixIcon: const Icon(Icons.notification_important, color: Colors.redAccent),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text(AppTexts.get('save_batch'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}