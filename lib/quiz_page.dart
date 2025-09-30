import 'dart:io';
import 'package:flutter/material.dart';
import 'package:junbi/main.dart';
import 'package:path_provider/path_provider.dart';
import 'quiz_detail_page.dart';
import 'quiz_image_question_page.dart';
import 'quiz_hyeong_question_page.dart';
import 'package:path_provider/path_provider.dart'; // needed
import 'package:shared_preferences/shared_preferences.dart';



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
        print(results);
        _updateBelts();
      });
    } catch (e) {
      debugPrint("Error reading results from prefs: $e");
    }
  }
// Add counters for belts
int yellowCount = 0, greenCount = 0, blueCount = 0, redCount = 0, blackCount = 0;
int yellowHCCount = 0, greenHCCount = 0, blueHCCount = 0, redHCCount = 0, blackHCCount = 0;

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
    

  // check grandmaster condition
  if (yellow && green && blue && red && black &&
      yellowHC && greenHC && blueHC && redHC && blackHC) {
    yellow = green = blue = red = black = false;
    yellowHC = greenHC = blueHC = redHC = blackHC = false;
    grandmaster = true;
  }
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
    questionTypes = [0, 1, 2, 3, 6, 7, 8]; // exclude 4 and 5(crashes)
  } else {
    questionTypes = [0, 2, 3, 6, 7, 8]; // exclude 1 and 4 and 5(crashes)
  }
  questionTypes.shuffle();
  int randomNumberQuestionType = questionTypes.first;

  // Navigate to the appropriate quiz page
      if (randomNumberQuestionType == 5) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (yellow)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/yellow_belt.png", width: 48),
                            if (yellowCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$yellowCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                      if (green)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/green_belt.png", width: 48),
                            if (greenCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$greenCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                      if (blue)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/blue_belt.png", width: 48),
                            if (blueCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$blueCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (red)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/red_belt.png", width: 48),
                            if (redCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$redCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (black)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/black_belt.png", width: 48),
                            if (blackCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$blackCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (yellowHC)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/yellow_belt_hardcore.png", width: 48),
                            if (yellowHCCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$yellowHCCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (greenHC)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/green_belt_hardcore.png", width: 48),
                            if (greenHCCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$greenHCCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (blueHC)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/blue_belt_hardcore.png", width: 48),
                            if (blueHCCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$blueHCCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (redHC)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/red_belt_hardcore.png", width: 48),
                            if (redHCCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$redHCCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                        if (blackHC)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/black_belt_hardcore.png", width: 48),
                            if (blackHCCount > 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.black,
                                  child: Text('x$blackHCCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                          ],
                        ),

                    ],
                  ),

                  if (grandmaster)
                    Image.asset("assets/images/sabeomnim.png", width: 120, height: 120)

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
                    MaterialPageRoute(builder: (_) => JunbiApp()), // or MainPage()
                    (route) => false, // remove all previous routes
                  );
                },
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

