import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart'; 

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';
  
  bool _isFirstRun = false; // متغير لمعرفة هل هي المرة الأولى للتطبيق
  String _savedPin = ''; 

  @override
  void initState() {
    super.initState();
    _loadPinFromMemory(); 
  }

  // دالة فحص الذاكرة الذكية
  void _loadPinFromMemory() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedPin = prefs.getString('app_pin');
    
    setState(() {
      if (storedPin == null) {
        // إذا لم يجد رمزاً، فهذه المرة الأولى
        _isFirstRun = true;
      } else {
        // إذا وجد رمزاً، يحفظه للمقارنة
        _isFirstRun = false;
        _savedPin = storedPin;
      }
    });
  }

  // دالة التعامل مع الإدخال (إنشاء أو تحقق)
  void _handlePinInput() async {
    if (_isFirstRun) {
      // في المرة الأولى: احفظ الرمز الذي أدخله المستخدم كرمز جديد
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_pin', _pinController.text);
      
      // الانتقال للوحة التحكم
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } else {
      // في المرات القادمة: قارن الرمز المدخل بالرمز المحفوظ
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
              Icon(
                _isFirstRun ? Icons.lock_open : Icons.lock_outline, // تغيير الأيقونة
                size: 100, 
                color: _isFirstRun ? Colors.green[700] : Colors.blue[800]
              ),
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
              // تغيير النص بناءً على حالة التطبيق
              Text(
                _isFirstRun 
                    ? 'مرحباً بك! قم بإنشاء رمز سري جديد (4 أرقام)' 
                    : 'الرجاء إدخال الرمز السري للمتابعة',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
                      _handlePinInput(); // استدعاء الدالة عند اكتمال 4 أرقام
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
