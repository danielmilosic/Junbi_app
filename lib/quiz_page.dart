import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'quiz_detail_page.dart';
import 'quiz_image_question_page.dart';
import 'quiz_hyeong_question_page.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool hardCoreMode = false;
  List<String> results = [];

  // belt image states
  bool yellow = false, green = false, blue = false, red = false, black = false;
  bool yellowHC = false, greenHC = false, blueHC = false, redHC = false, blackHC = false;
  bool grandmaster = false;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/results.txt');
      if (await file.exists()) {
        final lines = await file.readAsLines();
        setState(() {
          results = lines;
          _updateBelts();
        });
      }
    } catch (e) {
      debugPrint("Error reading results: $e");
    }
  }

  void _updateBelts() {
    for (var line in results) {
      if (line.contains("yellow_belt") && !line.contains("yellow_belt_hardcore")) yellow = true;
      if (line.contains("green_belt") && !line.contains("green_belt_hardcore")) green = true;
      if (line.contains("blue_belt") && !line.contains("blue_belt_hardcore")) blue = true;
      if (line.contains("red_belt") && !line.contains("red_belt_hardcore")) red = true;
      if (line.contains("black_belt") && !line.contains("black_belt_hardcore")) black = true;

      if (line.contains("yellow_belt_hardcore")) yellowHC = true;
      if (line.contains("green_belt_hardcore")) greenHC = true;
      if (line.contains("blue_belt_hardcore")) blueHC = true;
      if (line.contains("red_belt_hardcore")) redHC = true;
      if (line.contains("black_belt_hardcore")) blackHC = true;
    }

    // check grandmaster condition
    if (yellow && green && blue && red && black &&
        yellowHC && greenHC && blueHC && redHC && blackHC) {
      yellow = green = blue = red = black = false;
      yellowHC = greenHC = blueHC = redHC = blackHC = false;
      grandmaster = true;
    }
  }

void _startQuiz(int totalRounds) {
  // Determine random question type
  List<int> questionTypes;
  if (hardCoreMode) {
    questionTypes = [0, 1, 2, 3, 5, 6, 7, 8]; // exclude 4
  } else {
    questionTypes = [0, 2, 3, 5, 6, 7, 8]; // exclude 1 and 4
  }
  questionTypes.shuffle();
  int randomNumberQuestionType = questionTypes.first;

  // Navigate to the appropriate quiz page
  if (randomNumberQuestionType == 4) {
    // Image-based quiz page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizImageQuestionPage(
          totalRoundCount: totalRounds,
          hardCoreMode: hardCoreMode,
          randomNumberQuestionType: randomNumberQuestionType,
        ),
      ),
    );
  } if (randomNumberQuestionType >= 5) {
    // Image-based quiz page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizHyeongQuestionPage(
          totalRoundCount: totalRounds,
          hardCoreMode: hardCoreMode,
          randomNumberQuestionType: randomNumberQuestionType,
        ),
      ),
    );
  } else {
    // Regular text-based quiz page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizDetailPage(
          totalRoundCount: totalRounds,
          hardCoreMode: hardCoreMode,
          randomNumberQuestionType: randomNumberQuestionType,
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:50.0, left:20, right:20, bottom:20),
        child: Column(
          children: [
            // Hardcore Button
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    hardCoreMode = !hardCoreMode;
                  });
                },
                child: Text(
                  hardCoreMode ? "Hardcore Mode: ON" : "Hardcore",
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),


            // Title
            const Text("Quiz",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            const Text(
              "Wähle den Schwierigkeitsgrad passend zu deinem Gürtel",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            // Belt Buttons
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _beltButton("8. Geup", "8급", Colors.yellow, Colors.black, 10),
                    _beltButton("6. Geup", "6급", Colors.green, Colors.black, 15),
                    _beltButton("4. Geup", "4급", Colors.blue, Colors.white, 20),
                    _beltButton("2. Geup", "2급", Colors.red, Colors.white, 25),
                    _beltButton("1. Dan", "1단", Colors.black, Colors.white, 30),
                  ],
                ),
              ),
            ),

            // Belts / Grandmaster Images
            if (grandmaster)
              Image.asset("assets/sabeomnim.png", width: 120, height: 120)
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (yellow) Image.asset("assets/yellow_belt.png", width: 48),
                      if (green) Image.asset("assets/green_belt.png", width: 48),
                      if (blue) Image.asset("assets/blue_belt.png", width: 48),
                      if (red) Image.asset("assets/red_belt.png", width: 48),
                      if (black) Image.asset("assets/black_belt.png", width: 48),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (yellowHC) Image.asset("assets/yellow_belt_hardcore.png", width: 48),
                      if (greenHC) Image.asset("assets/green_belt_hardcore.png", width: 48),
                      if (blueHC) Image.asset("assets/blue_belt_hardcore.png", width: 48),
                      if (redHC) Image.asset("assets/red_belt_hardcore.png", width: 48),
                      if (blackHC) Image.asset("assets/black_belt_hardcore.png", width: 48),
                    ],
                  ),
                ],
              ),
                                                          // Custom back button
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _beltButton(String label, String hardcoreLabel,
      Color color, Color textColor, int rounds) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size.fromHeight(48),
        ),
        onPressed: () => _startQuiz(rounds),
        child: Text(
          hardCoreMode ? hardcoreLabel : label,
          style: TextStyle(fontSize: 24, color: textColor),
        ),
      ),
    );
  }
}

