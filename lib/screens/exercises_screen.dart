import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../data/curriculum_data.dart';
import '../services/tts_service.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});
  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  int qIndex = 0;
  int? selected;
  bool correct = false, finished = false;

  void checkAnswer(int i) {
    final q = Curriculum.questions[qIndex];
    setState(() {
      selected = i;
      correct = i == q.correct;
    });
    if (correct) {
      context.read<GameProvider>().solvedExercise();
      TtsService.speak(q.answers[i]);
    } else {
      TtsService.speak('Try again!');
    }
  }

  void next() {
    if (qIndex == Curriculum.questions.length - 1) {
      setState(() => finished = true);
    } else {
      setState(() {
        selected = null;
        correct = false;
        qIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (finished) {
      return Scaffold(
        backgroundColor: const Color(0xFF3B4CCA),
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('🏆', style: TextStyle(fontSize: 100)),
          const Text('Great Job!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () => Navigator.pop(context),
            child: const Text('Home'),
          ),
        ])),
      );
    }
    final q = Curriculum.questions[qIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF3B4CCA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5FE0),
        leading: const BackButton(color: Colors.white),
        title: Text('Question qIndex+1/{qIndex + 1}/qIndex+1/{Curriculum.questions.length}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFEEF2FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(q.question, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(q.image, fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 80)),
            ),
          ),
          ...q.answers.asMap().entries.map((e) {
            final sel = selected == e.key;
            final isC = e.key == q.correct;
            Color bg = Colors.blue.shade100;
            if (sel) bg = isC ? Colors.green : Colors.red.shade300;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: bg,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: selected == null ? () => checkAnswer(e.key) : null,
                child: Text(e.value,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            );
          }),
          if (correct) ...[
            const Text('🎉 Well Done! +10 stars',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: next,
              child: const Text('Next', style: TextStyle(color: Colors.white)),
            ),
          ],
        ]),
      ),
    );
  }
}
