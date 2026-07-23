import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueGrey, 
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  'إعدادات النظام والأمان',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ),
              // خيار تغيير الرمز السري الذي سنقوم ببرمجته لاحقاً
              _buildSettingItem(context, 'تغيير الرمز السري (PIN)', Icons.lock_outline, 'تحديث رمز الدخول لتطبيق Stockly'),
              _buildSettingItem(context, 'النسخ الاحتياطي', Icons.cloud_upload_outlined, 'حفظ نسخة أمان من بيانات المخزون'),
              _buildSettingItem(context, 'المظهر', Icons.dark_mode_outlined, 'تفعيل الوضع الداكن (Dark Mode)'),
              _buildSettingItem(context, 'لغة التطبيق', Icons.language, 'العربية (الافتراضية)'),
              
              const SizedBox(height: 30),
              
              // زر تسجيل الخروج / قفل التطبيق
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: () {
                  // العودة إلى شاشة الرمز السري الأولى
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('قفل التطبيق', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء عناصر الإعدادات بشكل متناسق
  Widget _buildSettingItem(BuildContext context, String title, IconData icon, String subtitle) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey.withOpacity(0.1),
          child: Icon(icon, color: Colors.blueGrey),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('قريباً: فتح إعدادات $title')),
          );
        },
      ),
    );
  }
}