import 'package:flutter/material.dart';
//other pages here
import 'hyeong_page.dart';
import 'techniques_page.dart';
import 'statistics_page.dart';
import 'motschger_box_page.dart';
import 'quiz_page.dart';
import 'hangul_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(66, 0, 0, 0)),
      ),
      home: const JunbiHomePage(),
    );
  }
}

class JunbiHomePage extends StatelessWidget {
  const JunbiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateTo(Widget page) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Taekwondo',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              // Subtitle (Hangul)
              const Text(
                '태권도',
                style: TextStyle(
                  fontSize: 48,
                ),
                textAlign: TextAlign.center,
              ),

              // Intro text
              const SizedBox(height: 16),
              const Text(
                'Willkommen bei Junbi, die App für traditionelles Taekwondo.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Buttons
              SizedBox(
                width: 266,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => navigateTo(HyeongPage()),
                      child: const Text(
                        'Hyeong (형)',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => navigateTo(TechniquesPage()),
                      child: const Text(
                        'Begriffe',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => navigateTo(StatisticsPage()),
                      child: const Text(
                        'Statistik',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => navigateTo(MotschgerBoxPage()),
                      child: const Text(
                        'Motschger Box',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => navigateTo(QuizPage()),
                      child: const Text(
                        'Quiz',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => navigateTo(HangulPage()),
                      child: const Text(
                        '한글',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
