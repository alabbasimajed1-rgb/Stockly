import 'package:flutter/material.dart';

class FefoWithdrawScreen extends StatefulWidget {
  const FefoWithdrawScreen({Key? key}) : super(key: key);

  @override
  _FefoWithdrawScreenState createState() => _FefoWithdrawScreenState();
}

class _FefoWithdrawScreenState extends State<FefoWithdrawScreen> {
  // بيانات وهمية تمثل الدفعات الموجودة في المخزن (مرتبة بحيث يظهر الأقرب انتهاءً أولاً)
  final List<Map<String, dynamic>> _batches = [
    {
      'item': 'محلول ملحي (Normal Saline)',
      'batch': 'B-789',
      'expiry': '2026/08/15', // تاريخ قريب جداً
      'qty': 50,
      'isUrgent': true, // مؤشر للتحذير اللوني
    },
    {
      'item': 'خيوط جراحية',
      'batch': 'S-102',
      'expiry': '2026/12/01', // تاريخ متوسط
      'qty': 120,
      'isUrgent': false,
    },
    {
      'item': 'محلول ملحي (Normal Saline)',
      'batch': 'B-800',
      'expiry': '2027/05/20', // تاريخ بعيد (نفس الصنف لكن دفعة أحدث)
      'qty': 200,
      'isUrgent': false,
    },
  ];

  final TextEditingController _withdrawController = TextEditingController();

  // دالة لفتح نافذة السحب
  void _showWithdrawDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('سحب من: ${_batches[index]['item']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('الكمية المتاحة: ${_batches[index]['qty']} وحدة', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(
                controller: _withdrawController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الكمية المراد سحبها',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _withdrawController.clear();
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                if (_withdrawController.text.isNotEmpty) {
                  int withdrawAmount = int.parse(_withdrawController.text);
                  if (withdrawAmount <= _batches[index]['qty']) {
                    setState(() {
                      _batches[index]['qty'] -= withdrawAmount;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل عملية السحب بنجاح!')),
                    );
                    _withdrawController.clear();
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الكمية المطلوبة أكبر من المتاح!'), backgroundColor: Colors.red),
                    );
                  }
                }
              },
              child: const Text('تأكيد السحب', style: TextStyle(color: Colors.white)),
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
        title: const Text('سحب المخزون (FEFO)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red, // لون التنبيه والسحب
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _batches.length,
            itemBuilder: (context, index) {
              final batch = _batches[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: batch['isUrgent'] ? 8 : 2, // بروز أكبر للكرت العاجل
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: batch['isUrgent'] ? Colors.red : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              batch['item'],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (batch['isUrgent'])
                            const Icon(Icons.warning_amber_rounded, color: Colors.red),
                        ],
                      ),
                      const Divider(),
                      Text('رقم التشغيلة (Batch): ${batch['batch']}'),
                      Text(
                        'تاريخ الانتهاء: ${batch['expiry']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: batch['isUrgent'] ? Colors.red : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المتاح: ${batch['qty']} وحدة',
                            style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[50]),
                            onPressed: () => _showWithdrawDialog(index),
                            icon: const Icon(Icons.outbox, color: Colors.red),
                            label: const Text('سحب', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}