import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization.dart';
import 'home_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _enteredPin = '';
  String? _savedPin;
  bool _isCreatingPin = false;
  String _tempPin = '';

  @override
  void initState() {
    super.initState();
    _loadPin();
  }

  Future<void> _loadPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedPin = prefs.getString('user_pin');
      if (_savedPin == null) {
        _isCreatingPin = true; // مستخدم جديد: اطلب منه إنشاء رمز
      }
    });
  }

  void _onNumberPressed(String number) {
    if (_enteredPin.length < 4) {
      setState(() => _enteredPin += number);
      if (_enteredPin.length == 4) {
        _verifyPin();
      }
    }
  }

  void _verifyPin() async {
    if (_isCreatingPin) {
      if (_tempPin.isEmpty) {
        // تم إدخال الرمز لأول مرة، اطلب التأكيد
        setState(() {
          _tempPin = _enteredPin;
          _enteredPin = '';
        });
      } else {
        // التأكيد
        if (_tempPin == _enteredPin) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_pin', _enteredPin);
          _navigateToHome();
        } else {
          _showError(AppTexts.get('pin_mismatch_error') ?? 'PIN mismatch');
          setState(() {
            _tempPin = '';
            _enteredPin = '';
          });
        }
      }
    } else {
      // مستخدم قديم، تحقق من الرمز
      if (_enteredPin == _savedPin) {
        _navigateToHome();
      } else {
        _showError(AppTexts.get('pin_error') ?? 'Incorrect PIN');
        setState(() => _enteredPin = '');
      }
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    String message = _isCreatingPin 
        ? (_tempPin.isEmpty ? (AppTexts.get('create_pin_msg') ?? 'Create a new 4-digit PIN') : (AppTexts.get('confirm_pin_msg') ?? 'Confirm your new PIN'))
        : (AppTexts.get('enter_pin_msg') ?? 'Enter your 4-digit PIN');

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Stockly', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 10),
            Text(message, style: const TextStyle(fontSize: 18, color: Colors.black87)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _enteredPin.length ? Colors.blue : Colors.transparent,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 250,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) return const SizedBox.shrink(); // فراغ
                  if (index == 11) { // زر المسح
                    return IconButton(
                      icon: const Icon(Icons.backspace, color: Colors.red),
                      onPressed: () {
                        if (_enteredPin.isNotEmpty) setState(() => _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1));
                      },
                    );
                  }
                  String number = index == 10 ? '0' : '${index + 1}';
                  return TextButton(
                    onPressed: () => _onNumberPressed(number),
                    child: Text(number, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
