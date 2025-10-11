import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:junbi/main.dart';
import 'package:path_provider/path_provider.dart';
import 'quiz_detail_page.dart';
import 'quiz_image_question_page.dart';
import 'quiz_hyeong_question_page.dart';
import 'package:path_provider/path_provider.dart'; // needed
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';



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
      final prefs = await SharedPreferences.getInstance();
      final storedResults = prefs.getStringList('results') ?? [];
      setState(() {
        results = storedResults;
        _updateBelts();
      });
    } catch (e) {
      debugPrint("Error reading results from prefs: $e");
    }
  }
// Add counters for belts
int yellowCount = 0, greenCount = 0, blueCount = 0, redCount = 0, blackCount = 0;
int yellowHCCount = 0, greenHCCount = 0, blueHCCount = 0, redHCCount = 0, blackHCCount = 0;
int grandmasterCount = 0;

  void _updateBelts() {
    // Reset everything
    yellow = green = blue = red = black = false;
    yellowHC = greenHC = blueHC = redHC = blackHC = false;
    yellowCount = greenCount = blueCount = redCount = blackCount = 0;
    yellowHCCount = greenHCCount = blueHCCount = redHCCount = blackHCCount = 0;
    grandmaster = false;

    for (var line in results) {
      if (line.contains("yellow_belt") && !line.contains("yellow_belt_hardcore")) {
        yellow = true;
        yellowCount++;
      }
      if (line.contains("green_belt") && !line.contains("green_belt_hardcore")) {
        green = true;
        greenCount++;
      }
      if (line.contains("blue_belt") && !line.contains("blue_belt_hardcore")) {
        blue = true;
        blueCount++;
      }
      if (line.contains("red_belt") && !line.contains("red_belt_hardcore")) {
        red = true;
        redCount++;
      }
      if (line.contains("black_belt") && !line.contains("black_belt_hardcore")) {
        black = true;
        blackCount++;
      }

      if (line.contains("yellow_belt_hardcore")) {
        yellowHC = true;
        yellowHCCount++;
      }
      if (line.contains("green_belt_hardcore")) {
        greenHC = true;
        greenHCCount++;
      }
      if (line.contains("blue_belt_hardcore")) {
        blueHC = true;
        blueHCCount++;
      }
      if (line.contains("red_belt_hardcore")) {
        redHC = true;
        redHCCount++;
      }
      if (line.contains("black_belt_hardcore")) {
        blackHC = true;
        blackHCCount++;
      }
}

    // check grandmaster condition
    if (yellow && green && blue && red && black &&
        yellowHC && greenHC && blueHC && redHC && blackHC) {
      grandmaster = true;
    }
        if (grandmaster) {
      grandmasterCount = [
        yellowCount,
        greenCount,
        blueCount,
        redCount,
        blackCount,
        yellowHCCount,
        greenHCCount,
        blueHCCount,
        redHCCount,
        blackHCCount
      ].reduce(min);
    }
  }

void _startQuiz(int totalRounds) {
  // Determine random question type
  List<int> questionTypes;
  if (hardCoreMode) {
    questionTypes = [0, 1, 2, 6, 7, 8]; // exclude 3, 4 and 5(crashes)
  } else {
    questionTypes = [0, 2, 6, 7, 8]; // exclude 1, 3, 4 and 5(crashes)
  }
  questionTypes.shuffle();
  int randomNumberQuestionType = questionTypes.first;

  // Navigate to the appropriate quiz page
      if (randomNumberQuestionType == 5) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => QuizImageQuestionPage(
              totalRoundCount: totalRounds,
              hardCoreMode: hardCoreMode,
              randomNumberQuestionType: randomNumberQuestionType,
            ),
          ),
    );
  } if (randomNumberQuestionType > 5) {
    // Image-based quiz page
    Navigator.push(
      context,
      CupertinoPageRoute(
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
      CupertinoPageRoute(
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
        child: SingleChildScrollView(
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
          
              const SizedBox(height:25),
              // Belt Buttons
              Center(
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
          const SizedBox(height: 15),
             // Belts / Grandmaster Images
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ────────────── Row 1: Regular Belts ──────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (yellow)
                                _beltImage("assets/images/yellow_belt.png", yellowCount, 48),
                              if (green)
                                _beltImage("assets/images/green_belt.png", greenCount, 48),
                              if (blue)
                                _beltImage("assets/images/blue_belt.png", blueCount, 48),
                              if (red)
                                _beltImage("assets/images/red_belt.png", redCount, 48),
                              if (black)
                                _beltImage("assets/images/black_belt.png", blackCount, 48),
                            ],
                          ),
          
                          const SizedBox(height: 8), // spacing between rows
          
                          // ────────────── Row 2: Hardcore Belts ──────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (yellowHC)
                                _beltImage("assets/images/yellow_belt_hardcore.png", yellowHCCount, 48),
                              if (greenHC)
                                _beltImage("assets/images/green_belt_hardcore.png", greenHCCount, 48),
                              if (blueHC)
                                _beltImage("assets/images/blue_belt_hardcore.png", blueHCCount, 48),
                              if (redHC)
                                _beltImage("assets/images/red_belt_hardcore.png", redHCCount, 48),
                              if (blackHC)
                                _beltImage("assets/images/black_belt_hardcore.png", blackHCCount, 48),
                            ],
                          ),
          
                          const SizedBox(height: 12), // spacing before grandmaster image
          
                          // ────────────── Row 3: Grandmaster ──────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (grandmaster)
                                _beltImage("assets/images/sabeomnim.png", grandmasterCount, 70),
                            ],
                          ),
                        ],
                      ),
          
                                                            // Custom back button
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (_) => JunbiApp()), // or MainPage()
                      (route) => false, // remove all previous routes
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _beltImage(String assetPath, int count, double imageSize) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0), // small gap between belts
          child: Hero(tag:assetPath, child: Image.asset(assetPath, width: imageSize)),
        ),
        if (count > 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              color: const Color.fromARGB(255, 51, 51, 51),
              child: Text(
                'x$count',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
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

