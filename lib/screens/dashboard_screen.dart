import 'package:flutter/material.dart';
import '../localization.dart'; // استدعاء القاموس
import 'items_screen.dart'; 
import 'add_batch_screen.dart'; 
import 'fefo_withdraw_screen.dart'; 
import 'history_screen.dart'; 
import 'reports_screen.dart'; 
import 'settings_screen.dart';

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
        // استدعاء نص عنوان الشاشة من القاموس
        title: Text(
          AppTexts.get('dashboard_title'), 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
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
                // استدعاء نص الترحيب من القاموس
                Text(
                  AppTexts.get('welcome'),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      // استدعاء نصوص الأزرار من القاموس
                      _buildDashboardCard(AppTexts.get('items'), Icons.inventory, Colors.orange, const ItemsScreen()),
                      _buildDashboardCard(AppTexts.get('add_batch'), Icons.add_box, Colors.green, const AddBatchScreen()),
                      _buildDashboardCard(AppTexts.get('fefo_withdraw'), Icons.outbox, Colors.red, const FefoWithdrawScreen()),
                      _buildDashboardCard(AppTexts.get('history'), Icons.history, Colors.blue, const HistoryScreen()),
                      _buildDashboardCard(AppTexts.get('reports'), Icons.bar_chart, Colors.purple, const ReportsScreen()),
                      _buildDashboardCard(AppTexts.get('settings'), Icons.settings, Colors.blueGrey, const SettingsScreen()),
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