import 'package:flutter/material.dart';
import '../localization.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'محلول ملحي (Normal Saline)', 'stock': 120, 'icon': Icons.local_hospital, 'color': Colors.blue},
    {'name': 'مسكن ألم (Paracetamol)', 'stock': 45, 'icon': Icons.medication, 'color': Colors.red},
    {'name': 'مضاد حيوي (Amoxicillin)', 'stock': 15, 'icon': Icons.healing, 'color': Colors.orange},
  ];

  void _showItemDialog({Map<String, dynamic>? item, int? index}) {
    final TextEditingController nameController = TextEditingController(text: item?['name'] ?? '');
    final bool isEditing = item != null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(isEditing ? 'تعديل الصنف' : AppTexts.get('add_new_item')),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'اسم الصنف',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppTexts.get('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    if (isEditing) {
                      _items[index!]['name'] = nameController.text;
                    } else {
                      _items.add({
                        'name': nameController.text,
                        'stock': 0, 
                        'icon': Icons.inventory,
                        'color': Colors.green,
                      });
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('حفظ'),
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
        title: Text(AppTexts.get('items'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: AppTexts.get('search_item'),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item['color'].withOpacity(0.2), 
                          child: Icon(item['icon'], color: item['color'])
                        ),
                        title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('المخزون: ${item['stock']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () => _showItemDialog(item: item, index: index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showItemDialog(),
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add),
        label: Text(AppTexts.get('add_new_item'), style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
