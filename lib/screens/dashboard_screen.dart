import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold هو الهيكل الأساسي لأي شاشة
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لوحة التحكم - Stockly', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مرحباً بك،',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // GridView لترتيب الأزرار الرئيسية في شبكة
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // عدد الأعمدة
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard('الأصناف والفئات', Icons.inventory, Colors.orange),
                  _buildDashboardCard('إضافة دفعة', Icons.add_box, Colors.green),
                  _buildDashboardCard('سحب (FEFO)', Icons.outbox, Colors.red),
                  _buildDashboardCard('السجل والفعاليات', Icons.history, Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لبناء كروت الواجهة بشكل أنيق ومختصر
  Widget _buildDashboardCard(String title, IconData icon, MaterialColor color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // سيتم هنا برمجة الانتقال للشاشات الفرعية لاحقاً
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('قريباً: فتح شاشة $title')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title, 
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}