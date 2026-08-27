import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFF3B4CCA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5FE0),
        leading: const BackButton(color: Colors.white),
        title: const Text('My Rewards',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFEEF2FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: GameProvider.allBadges.map((b) {
            final unlocked = game.hasBadge(b.id);
            return Card(
              color: unlocked ? Colors.amber.shade100 : Colors.grey.shade300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Opacity(
                    opacity: unlocked ? 1 : 0.3,
                    child: Text(b.emoji, style: const TextStyle(fontSize: 55))),
                Text(b.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(unlocked ? 'Unlocked' : 'Locked: ${b.requiredStars} stars',
                    style: const TextStyle(fontSize: 12)),
              ]),
            );
          }).toList(),
        ),
      ),
    );
  }
}
