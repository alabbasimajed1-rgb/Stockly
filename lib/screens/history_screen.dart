import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  // بيانات وهمية تمثل سجل الحركات السابقة
  final List<Map<String, dynamic>> _logs = const [
    {'action': 'سحب (FEFO)', 'item': 'محلول ملحي (Normal Saline)', 'qty': 10, 'date': '2026/07/23 14:30', 'type': 'out'},
    {'action': 'إضافة دفعة', 'item': 'خيوط جراحية', 'qty': 120, 'date': '2026/07/22 09:15', 'type': 'in'},
    {'action': 'سحب (FEFO)', 'item': 'مسكن ألم (Paracetamol)', 'qty': 5, 'date': '2026/07/21 20:00', 'type': 'out'},
    {'action': 'إضافة صنف', 'item': 'مضاد حيوي (Amoxicillin)', 'qty': 0, 'date': '2026/07/20 11:00', 'type': 'info'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('السجل والفعاليات', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue, // اللون الأزرق الخاص بالسجل
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _logs.length,
            itemBuilder: (context, index) {
              final log = _logs[index];
              IconData icon;
              Color color;
              
              // تحديد لون وأيقونة الحركة (أخضر للدخول، أحمر للخروج، أزرق للمعلومات)
              if (log['type'] == 'in') {
                icon = Icons.arrow_downward;
                color = Colors.green;
              } else if (log['type'] == 'out') {
                icon = Icons.arrow_upward;
                color = Colors.red;
              } else {
                icon = Icons.info_outline;
                color = Colors.blue;
              }

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withOpacity(0.2),
                    child: Icon(icon, color: color),
                  ),
                  title: Text(
                    '${log['action']}: ${log['item']}', 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  subtitle: Text(log['date']),
                  trailing: log['qty'] > 0
                      ? Text(
                          '${log['type'] == 'in' ? '+' : '-'}${log['qty']}',
                          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}