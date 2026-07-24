import 'package:flutter/material.dart';
import '../localization.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  void _showDetails(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(AppTexts.get('details_soon') ?? 'Detailed view will be available once database is connected.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppTexts.get('close') ?? 'Close'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.get('reports') ?? 'Reports', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Inventory Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ),
              _buildReportCard(
                title: AppTexts.get('total_items') ?? 'Total Items',
                subtitle: '0 registered items',
                icon: Icons.bar_chart,
                color: Colors.blue,
                onTap: () => _showDetails(context, AppTexts.get('total_items') ?? 'Total Items'),
              ),
              _buildReportCard(
                title: AppTexts.get('stock_shortages') ?? 'Stock Shortages',
                subtitle: '0 items below minimum',
                icon: Icons.warning_amber_rounded,
                color: Colors.orange,
                onTap: () => _showDetails(context, AppTexts.get('stock_shortages') ?? 'Stock Shortages'),
              ),
              _buildReportCard(
                title: AppTexts.get('expiry_alerts') ?? 'Expiry Alerts (FEFO)',
                subtitle: '0 batches nearing expiry',
                icon: Icons.date_range,
                color: Colors.redAccent,
                onTap: () => _showDetails(context, AppTexts.get('expiry_alerts') ?? 'Expiry Alerts'),
              ),
              _buildReportCard(
                title: AppTexts.get('todays_movement') ?? 'Today\'s Movement',
                subtitle: '0 operations (In/Out)',
                icon: Icons.swap_horiz,
                color: Colors.green,
                onTap: () => _showDetails(context, AppTexts.get('todays_movement') ?? 'Today\'s Movement'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.2), radius: 25, child: Icon(icon, color: color, size: 28)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
