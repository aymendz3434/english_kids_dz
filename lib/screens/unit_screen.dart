import 'package:flutter/material.dart';
import '../data/curriculum_data.dart';
import '../services/tts_service.dart';

class UnitScreen extends StatelessWidget {
  final SchoolYear schoolYear;
  const UnitScreen({super.key, required this.schoolYear});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B4CCA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5FE0),
        leading: const BackButton(color: Colors.white),
        title: Text('${schoolYear.title} — Modules',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFEEF2FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: schoolYear.modules.length,
          itemBuilder: (_, mi) {
            final module = schoolYear.modules[mi];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Module mi+1:{mi + 1}:mi+1:{module.title}',
                        style: const TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold, color: Color(0xFF3B4CCA))),
                  ),
                  ...module.lessons.map((lesson) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(lesson.emoji, style: const TextStyle(fontSize: 22)),
                                  const SizedBox(width: 8),
                                  Text('lesson.type:{lesson.type}:lesson.type:{lesson.title}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                ]),
                                const SizedBox(height: 10),
                                lesson.type == 'Dialogue'
                                    ? _dialogueView(lesson)
                                    : _vocabularyGrid(lesson),
                              ]),
                        ),
                      )),
                ]);
          },
        ),
      ),
    );
  }

  static Widget _vocabularyGrid(Lesson lesson) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8,
          childAspectRatio: 0.85),
      itemCount: lesson.items.length,
      itemBuilder: (_, wi) {
        final item = lesson.items[wi];
        final isImage = item.image.startsWith('assets');
        return GestureDetector(
          onTap: () => TtsService.speak(item.word),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(14)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: isImage
                      ? Image.asset(item.image, fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image, size: 40))
                      : Text(item.image, style: const TextStyle(fontSize: 40)),
                ),
              ),
              Text(item.word,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const Icon(Icons.volume_up, size: 14, color: Colors.blue),
            ]),
          ),
        );
      },
    );
  }

  static Widget _dialogueView(Lesson lesson) {
    return Column(children: [
      ...lesson.items.asMap().entries.map((e) {
        final isRight = e.key.isEven;
        return Align(
          alignment: isRight ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: () => TtsService.speak(e.value.word),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              constraints: const BoxConstraints(maxWidth: 260),
              decoration: BoxDecoration(
                color: isRight ? Colors.blue.shade100 : Colors.orange.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isRight ? 4 : 16),
                  bottomRight: Radius.circular(isRight ? 16 : 4),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Flexible(child: Text(e.value.word,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                const SizedBox(width: 6),
                const Icon(Icons.volume_up, size: 15, color: Colors.blue),
              ]),
            ),
          ),
        );
      }),
    ]);
  }
}
