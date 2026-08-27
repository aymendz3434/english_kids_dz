import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  String? error;
  bool unlocked = false;

  static const String accessCode = 'aa18ay25';

  @override
  void initState() {
    super.initState();
    _checkSaved();
  }

  Future<void> _checkSaved() async {
    final p = await SharedPreferences.getInstance();
    if (p.getBool('unlocked') == true && mounted) _goHome();
  }

  void _goHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  Future<void> _tryLogin() async {
    if (_controller.text.trim() == accessCode) {
      final p = await SharedPreferences.getInstance();
      await p.setBool('unlocked', true);
      setState(() => unlocked = true);
      Future.delayed(const Duration(milliseconds: 800), _goHome);
    } else {
      setState(() {
        error = '❌ Wrong code! Try again.';
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF3B4CCA), Color(0xFF6C7BFF)],
                begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: unlocked
                ? const Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('🔓', style: TextStyle(fontSize: 80)),
                    Text('Welcome!',
                        style: TextStyle(fontSize: 30, fontWeight:
                            FontWeight.bold, color: Colors.white)),
                  ])
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('🔒', style: TextStyle(fontSize: 70)),
                    const SizedBox(height: 16),
                    const Text('Enter Access Code',
                        style: TextStyle(fontSize: 26, fontWeight:
                            FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text('أدخل كود الدخول للمتابعة',
                        style: TextStyle(fontSize: 14, color: Colors.white70)),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _controller,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold, letterSpacing: 2),
                      decoration: InputDecoration(
                        hintText: '• • • • • • • •',
                        filled: true, fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        errorText: error,
                      ),
                      onSubmitted: (_) => _tryLogin(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: _tryLogin,
                      child: const Text('🔓 Unlock',
                          style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ]),
          ),
        ),
      ),
    );
  }
}
