import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';

  // دالة للتحقق من الرمز
  void _checkPin() async {
    if (_pinController.text == '0000') {
      // الكود الجديد: الانتقال للشاشة الرئيسية وإغلاق شاشة الرمز
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
                  obscureText: true, // لإخفاء الأرقام بنجوم/نقاط
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  style: const TextStyle(fontSize: 24, letterSpacing: 15),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    counterText: '', // لإخفاء عداد الحروف أسفل المربع
                  ),
                  onChanged: (value) {
                    // التحقق التلقائي بمجرد كتابة 4 أرقام
                    if (value.length == 4) {
                      _checkPin();
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _errorMessage,
                style: TextStyle(
                  color: _errorMessage.contains('صحيح') ? Colors.green : Colors.red, 
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