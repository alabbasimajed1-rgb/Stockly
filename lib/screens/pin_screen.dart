import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استدعاء مكتبة الذاكرة
import 'dashboard_screen.dart'; 

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';
  
  // متغير لحفظ الرمز السري المقروء من الذاكرة (الافتراضي 0000)
  String _savedPin = '0000'; 

  @override
  void initState() {
    super.initState();
    _loadPinFromMemory(); // استدعاء الدالة عند فتح الشاشة فوراً
  }

  // دالة للاتصال بالذاكرة وجلب الرمز السري
  void _loadPinFromMemory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // البحث عن مفتاح باسم 'app_pin'، إذا لم يجده يضع '0000'
      _savedPin = prefs.getString('app_pin') ?? '0000'; 
    });
  }

  // دالة للتحقق من الرمز
  void _checkPin() {
    // الآن نقارن الرمز المدخل بالرمز المحفوظ في الذاكرة بدلاً من النص الثابت
    if (_pinController.text == _savedPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'الرمز السري غير صحيح';
        _pinController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 100, color: Colors.blue[800]),
              const SizedBox(height: 20),
              Text(
                'Stockly',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blue[800]
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'الرجاء إدخال الرمز السري للمتابعة',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  style: const TextStyle(fontSize: 24, letterSpacing: 15),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    counterText: '', 
                  ),
                  onChanged: (value) {
                    if (value.length == 4) {
                      _checkPin();
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _errorMessage,
                style: const TextStyle(
                  color: Colors.red, 
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}