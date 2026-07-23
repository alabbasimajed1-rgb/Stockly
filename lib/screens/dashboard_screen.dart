import 'package:flutter/material.dart';
import 'items_screen.dart'; 
import 'add_batch_screen.dart'; 
import 'fefo_withdraw_screen.dart'; 
import 'history_screen.dart'; 
import 'reports_screen.dart'; 
import 'settings_screen.dart'; // الاستدعاء الجديد لشاشة الإعدادات

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450), 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً بك،',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildDashboardCard('الأصناف والفئات', Icons.inventory, Colors.orange, const ItemsScreen()),
                      _buildDashboardCard('إضافة دفعة', Icons.add_box, Colors.green, const AddBatchScreen()),
                      _buildDashboardCard('سحب (FEFO)', Icons.outbox, Colors.red, const FefoWithdrawScreen()),
                      _buildDashboardCard('السجل والفعاليات', Icons.history, Colors.blue, const HistoryScreen()),
                      _buildDashboardCard('التقارير', Icons.bar_chart, Colors.purple, const ReportsScreen()),
                      // زر الإعدادات أصبح الآن متصلاً بالشاشة الخاصة به
                      _buildDashboardCard('الإعدادات', Icons.settings, Colors.blueGrey, const SettingsScreen()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء الأزرار بشكل أنيق ومختصر
  Widget _buildDashboardCard(String title, IconData icon, MaterialColor color, Widget? destination) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (destination != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('قريباً: فتح شاشة $title')),
            );
          }
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