import 'package:flutter/material.dart';
import '../data/curriculum_data.dart';
import 'unit_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = [Colors.green, Colors.blue, Colors.orange];
    return Scaffold(
      backgroundColor: const Color(0xFF3B4CCA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5FE0),
        leading: const BackButton(color: Colors.white),
        title: const Text('Choose Your Year',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFEEF2FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: Curriculum.years.length,
          itemBuilder: (_, i) {
            final y = Curriculum.years[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: colors[i],
                  child: Text('${y.year}',
                      style: const TextStyle(color: Colors.white, fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
                title: Text(y.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Text('${y.modules.length} modules · English'),
                trailing: const Icon(Icons.play_circle_fill,
                    color: Color(0xFF3B4CCA), size: 36),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UnitScreen(schoolYear: y))),
              ),
            );
          },
        ),
    );
  }
}
