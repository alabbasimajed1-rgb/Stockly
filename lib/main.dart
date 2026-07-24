import 'package:flutter/material.dart';
import 'screens/pin_screen.dart';
import 'localization.dart'; // استدعاء العقل المدبر للغات

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // هذه الأداة تراقب المتغير الذكي للغة، وتعيد بناء التطبيق عند تغييره
    return ValueListenableBuilder<String>(
      valueListenable: appLanguage,
      builder: (context, language, child) {
        return MaterialApp(
          title: 'Stockly',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Cairo', // يفضل استخدام خط يدعم اللغات بوضوح
          ),
          // إجبار التطبيق على تغيير الاتجاه (يمين/يسار) بناءً على اللغة
          builder: (context, child) {
            return Directionality(
              textDirection: AppTexts.getDirection(),
              child: child!,
            );
          },
          home: const PinScreen(),
        );
      },
    );
  }
}