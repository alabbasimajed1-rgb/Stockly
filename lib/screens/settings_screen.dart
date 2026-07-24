import 'package:flutter/material.dart';
import '../localization.dart'; // استدعاء القاموس

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  // دالة لإظهار نافذة اختيار اللغة
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(AppTexts.get('choose_language'), style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: const Text('English (Default)'),
                onTap: () {
                  appLanguage.value = 'en'; // تغيير اللغة للإنجليزية
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: const Text('العربية'),
                onTap: () {
                  appLanguage.value = 'ar'; // تغيير اللغة للعربية
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇩🇪', style: TextStyle(fontSize: 24)),
                title: const Text('Deutsch'),
                onTap: () {
                  appLanguage.value = 'de'; // تغيير اللغة للألمانية
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppTexts.get('cancel')),
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
        title: Text(AppTexts.get('settings'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueGrey, 
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  AppTexts.get('settings_title'),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ),
              // ربط النصوص بالقاموس
              _buildSettingItem(context, AppTexts.get('change_pin'), Icons.lock_outline, AppTexts.get('change_pin_sub'), null),
              _buildSettingItem(context, AppTexts.get('backup'), Icons.cloud_upload_outlined, AppTexts.get('backup_sub'), null),
              _buildSettingItem(context, AppTexts.get('appearance'), Icons.dark_mode_outlined, AppTexts.get('appearance_sub'), null),
              
              // زر اللغات يستدعي نافذة التغيير الآن
              _buildSettingItem(
                context, 
                AppTexts.get('app_language'), 
                Icons.language, 
                AppTexts.get('app_language_sub'), 
                () => _showLanguageDialog(context) // فتح النافذة
              ),
              
              const SizedBox(height: 30),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(AppTexts.get('lock_app'), style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, String subtitle, VoidCallback? onTap) {
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
        onTap: onTap ?? () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('قريباً: $title')),
          );
        },
      ),
    );
  }
}