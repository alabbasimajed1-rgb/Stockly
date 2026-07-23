import 'package:flutter/material.dart';
import 'screens/pin_screen.dart';

void main() {
  runApp(const StocklyApp());
}

class StocklyApp extends StatelessWidget {
  const StocklyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stockly',
      debugShowCheckedModeBanner: false, // هذه تخفي شريط Debug الأحمر المزعج من الشاشة
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      // الواجهة الأولى التي تفتح مع التطبيق
      home: const PinScreen(),
    );
  }
}