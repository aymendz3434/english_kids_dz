import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'services/tts_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TtsService.init();
  runApp(ChangeNotifierProvider(
      create: (_) => GameProvider()..load(),
      child: MaterialApp(
          title: 'English Kids DZ',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B4CCA)), useMaterial3: true          home: const SplashScreen())));
}
