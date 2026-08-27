import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 2))..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF3B4CCA), Color(0xFF6C7BFF)])),
        child: FadeTransition(
          opacity: _ctrl,
          child: const Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('🇬🇧', style: TextStyle(fontSize: 80)),
              Text('English Kids DZ',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Learn · Play · Shine',
                  style: TextStyle(fontSize: 18, color: Colors.amber)),
              SizedBox(height: 30),
              CircularProgressIndicator(color: Colors.amber),
            ]),
          ),
        ),
      ),
    );
  }
}
