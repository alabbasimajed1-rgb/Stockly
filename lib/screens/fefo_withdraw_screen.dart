import 'package:flutter/material.dart';
import '../localization.dart';

class FefoWithdrawScreen extends StatefulWidget {
  const FefoWithdrawScreen({Key? key}) : super(key: key);
  @override
  _FefoWithdrawScreenState createState() => _FefoWithdrawScreenState();
}

class _FefoWithdrawScreenState extends State<FefoWithdrawScreen> {
  String? _selectedItem;

  final List<String> _dummyItems = [
    'محلول ملحي (Normal Saline)', 'خيوط جراحية', 'مضاد حيوي (Amoxicillin)', 'مسكن ألم (Paracetamol)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.get('fefo_withdraw'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red[700],
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
                Container(
                  padding: const EdgeInsets.all(12),
                  // تم تصحيح الخطأ في هذا السطر
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange)),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.orange),
                      const SizedBox(width: 10),
                      Expanded(child: Text(AppTexts.get('fefo_alert'), style: const TextStyle(color: Colors.orange))),
                    ],
                  ),
                ),
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppTexts.get('withdraw_qty'),
                    prefixIcon: const Icon(Icons.remove_shopping_cart),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text(AppTexts.get('withdraw_btn'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}