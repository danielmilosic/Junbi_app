import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // For saving results locally
import 'quiz_page.dart'; // Your quiz page widget
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatefulWidget {
  final int correctCount;
  final int totalRoundCount;
  final bool hardCoreMode;

  const ResultsPage({
    Key? key,
    required this.correctCount,
    required this.totalRoundCount,
    required this.hardCoreMode,
  }) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String beltLevel = 'yellow';
  String beltName = 'none';
  String congratulationsText =
      'Diesmal erhälst du leider keinen Gürtel :( \nViel Glück beim nächsten Mal!';
  String beltImagePath = 'assets/images/white_belt.png';

  @override
  void initState() {
    super.initState();
    _determineBelt();
    _saveResultToPrefs();
  }

  void _determineBelt() {
    // Determine belt level based on totalRoundCount
    switch (widget.totalRoundCount) {
      case 10:
        beltLevel = 'yellow';
        break;
      case 15:
        beltLevel = 'green';
        break;
      case 20:
        beltLevel = 'blue';
        break;
      case 25:
        beltLevel = 'red';
        break;
      case 30:
        beltLevel = 'black';
        break;
      default:
        beltLevel = 'none';
    }

    // Only award belt if all answers are correct
    if (widget.correctCount > widget.totalRoundCount*0.79) {
      switch (widget.totalRoundCount) {
        case 10:
          beltName = 'yellow_belt';
          congratulationsText =
              'Herzlichen Glückwunsch zu deinem gelben Gürtel! :)';
          break;
        case 15:
          beltName = 'green_belt';
          congratulationsText =
              'Herzlichen Glückwunsch zu deinem grünen Gürtel! :)';
          break;
        case 20:
          beltName = 'blue_belt';
          congratulationsText =
              'Herzlichen Glückwunsch zu deinem blauen Gürtel! :)';
          break;
        case 25:
          beltName = 'red_belt';
          congratulationsText =
              'Herzlichen Glückwunsch zu deinem roten Gürtel! :)';
          break;
        case 30:
          beltName = 'black_belt';
          congratulationsText =
              'Herzlichen Glückwunsch zu deinem schwarzen Gürtel! :)';
          break;
      }

      if (widget.hardCoreMode) {
        beltName = '${beltName}_hardcore';
      }

      beltImagePath = 'assets/images/$beltName.png';
    }
  }

  Future<void> _saveResultToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList('results') ?? [];

    final newEntry =
        'Total:${widget.totalRoundCount},Correct:${widget.correctCount},Belt:$beltName,Level:$beltLevel';
    existing.add(newEntry);

    await prefs.setStringList('results', existing);
  }

  void _returnToQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const QuizPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.correctCount} / ${widget.totalRoundCount}',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Hero(
                  tag: beltImagePath,
                  child: Image.asset(
                    beltImagePath,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  congratulationsText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _returnToQuiz,
                  child: const Text('Zurück zum Quiz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
