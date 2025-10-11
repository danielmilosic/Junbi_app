import 'package:flutter/material.dart';
import 'package:junbi/categories_page.dart';
//other pages here
import 'hyeong_page.dart';
import 'techniques_page.dart';
import 'statistics_page.dart';
import 'motschger_box_page.dart';
import 'quiz_page.dart';
import 'hangul_page.dart';
import 'curriculum_page.dart';
import 'strings.dart';
import 'package:path_provider/path_provider.dart'; // needed


void main() {
  runApp(const JunbiApp());
}

class JunbiApp extends StatelessWidget {
  const JunbiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Junbi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 51, 51),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 51, 51, 51),
          onPrimary: const Color.fromARGB(255, 0, 0, 0), // text/icon color on AppBar, buttons, etc.
          onSurface: const Color.fromARGB(255, 0, 0, 0), // default text color on background
        ),


        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 235, 235, 235)),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 235, 235, 235)),
          bodySmall: TextStyle(color: Color.fromARGB(255, 235, 235, 235)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white, // text/icon color
          ),
        ),
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
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const Text(AppStrings.junbi_introduction_german,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                      
                  const SizedBox(height: 24),
                      
                  // Buttons
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () => navigateTo(HyeongPage()),
                            child: const Text(
                              'Hyeong',
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
                            onPressed: () => navigateTo(CurriculumPage()),
                            child: const Text(
                              'Kurrikulum',
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
                            onPressed: () => navigateTo(StatisticsPage()),
                            child: const Text(
                              'Statistik',
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
