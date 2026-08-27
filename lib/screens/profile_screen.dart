import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFF3B4CCA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5FE0),
        leading: const BackButton(color: Colors.white),
        title: const Text('My Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFEEF2FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(children: [
          const SizedBox(height: 24),
          const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF3B4CCA),
              child: Text('👦', style: TextStyle(fontSize: 45))),
          const SizedBox(height: 10),
          const Text('English Champion!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text('Stars: ${game.stars}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Level: ${game.level}', style: const TextStyle(fontSize: 20)),
          Text('Exercises solved: ${game.exercisesSolved}',
              style: const TextStyle(fontSize: 18)),
        ]),
      ),
    );
  }
}
