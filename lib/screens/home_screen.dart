import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'level_select_screen.dart';
import 'exercises_screen.dart';
import 'profile_screen.dart';
import 'rewards_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF3B4CCA), Color(0xFF6C7BFF)],
                begin: Alignment.topCenter)),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen())),
                  child: const CircleAvatar(
                      backgroundColor: Colors.white, child: Text('👦')),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    const Icon(Icons.star, color: Colors.white),
                    const SizedBox(width: 4),
                    Text('${game.stars}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20 child: const Column(children: [
                Text('🇬🇧 English Kids DZ',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
                        color: Color(0xFF3B4CCA))),
                Text('Algerian Primary Curriculum · Years 3-5',
                    style: TextStyle(fontSize: 14, color: Colors.orange)),
              ]),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(8),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _menu(context, '📚\nLessons', Colors.red, const LevelSelectScreen()),
                  _menu(context, '📝\nExercises', Colors.green, const ExercisesScreen()),
                  _menu(context, '🏆\nRewards', Colors.deepOrange, const RewardsScreen()),
                  _menu(context, '👦\nProfile', Colors.indigo, const ProfileScreen()),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  static Widget _menu(BuildContext ctx, String label, Color color, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => screen)),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: Text(label, textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15,
                  fontWeight: FontWeight.bold, height: 1.4)),
        ),
      ),
    );
  }
}
