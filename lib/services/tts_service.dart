import 'package:flutter_tts/flutter_tts.dart';

class TService {
  static final FlutterTts _tts = FlutterTts();
  static Future<void> init() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.4);
    await _tts.setPitch(1.2);
  }
  static Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }
}
