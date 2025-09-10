import 'package:flutter/material.dart';

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
                width: 266, // matches your LinearLayout width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Hyeong (형)',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Begriffe',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Statistik',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Motschger Box',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Quiz',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
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

