import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Badge {
  final String id, name, emoji;
  final int requiredStars;
  const Badge(this.id, this.name, this.emoji, this.requiredStars);
}

class GameProvider extends ChangeNotifier {
  int stars = 0, level = 1, exercisesSolved = 0;
  Set<String> unlockedBadges = {};

  static const allBadges = [
    Badge('first', 'Beginner', '🌟', 10),
    Badge('smart', 'Smart', '🧠', 50),
    Badge('champion', 'Champion', '🏆', 100),
    Badge('master', 'Master', '👑', 250),
  ];

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    stars = p.getInt('stars') ?? 0;
    exercisesSolved = p.getInt('solved') ?? 0;
    unlockedBadges = (p.getStringList('badges') ?? []).toSet();
    level = (stars ~/ 50) + 1;
    notifyListeners();
  }

  Future<void> addStars amount) async {
    stars += amount;
    level = (stars ~/ 50) + 1;
    for (final b in allBadges) {
      if (stars >= b.requiredStars) unlockedBadges.add(b.id);
    }
    final p = await SharedPreferences.getInstance();
    await p.setInt('stars', stars);
    await p.setInt('solved', exercisesSolved);
    await p.setStringList('badges', unlockedBadges.toList());
    notifyListeners();
  }

  void solvedExercise() {
    exercisesSolved++;
    addStars(10);
  }

  bool hasBadge(String id) => unlockedBadges.contains(id);
}
