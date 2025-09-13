import 'dart:async';
import 'package:flutter/material.dart';
import 'package:junbi/strings.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'quiz_hyeong_question_page.dart';
import 'quiz_detail_page.dart';

class QuizImageQuestionPage extends StatefulWidget {
  final int roundCount;
  final int totalRoundCount;
  final int correctCount;
  final int randomNumberQuestionType;
  final bool hardCoreMode;

  const QuizImageQuestionPage({
    super.key,
    this.roundCount = 0,
    required this.totalRoundCount,
    this.correctCount = 0,
    required this.hardCoreMode,
    required this.randomNumberQuestionType,
  });

  @override
  State<QuizImageQuestionPage> createState() => _QuizImageQuestionPageState();
}

class _QuizImageQuestionPageState extends State<QuizImageQuestionPage> {
  bool answerLockedIn = false;
  late List<int> randomNumberQuestionTypeList;
  late int randomNumberQuestionTypeNext;
  late List<String> listOfQuestions;
  late List<MapEntry<String, String>> listOfAllAnswers;
  late List<String> listOfAnswers;
  late List<String> listOfKeys;

  late int correctIndex;
  String correctAnswer = "";
  String correctKey = "";
  Timer? toggleTimer;
  bool toggle = false;

  late List<String> imagePaths;
  late List<String> startImagePaths;


  Future<bool> assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    // Random type of question (replicating your Kotlin logic)
    if (widget.hardCoreMode) {
      randomNumberQuestionTypeList = [0, 1, 2, 3, 5, 6, 7, 8]..shuffle();
    } else {
      randomNumberQuestionTypeList = [0, 2, 3, 5, 6, 7, 8]..shuffle();
    }
    randomNumberQuestionTypeNext = randomNumberQuestionTypeList.first;
    listOfQuestions = AppStrings.questions;

    // Map of key -> value for the selected question type
    final allEntries = AppStrings.techniqueInformation.entries
        .map((entry) =>
            MapEntry(entry.key, entry.value[0]))
        .toList();

    List<MapEntry<String, String>> selectedEntries;

    allEntries.shuffle();
    selectedEntries = allEntries.take(4).toList();
   
    listOfKeys = selectedEntries.map((e) => e.key).toList();
    listOfAnswers = selectedEntries.map((e) => e.value).toList();

    imagePaths = listOfKeys.map((key) => "assets/images/$key.png").toList();

    // By default, fall back to normal paths
    startImagePaths = List.from(imagePaths);

    // Try replacing with "_start.png" if it exists
    for (int i = 0; i < listOfKeys.length; i++) {
      final candidate = "assets/images/${listOfKeys[i]}_start.png";
      assetExists(candidate).then((exists) {
        if (exists) {
          setState(() {
            startImagePaths[i] = candidate;
          });
        }
      });
    }

    toggleTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        toggle = !toggle;
      });
    });


    // Pick correct answer index
    correctIndex =
        (List<int>.generate(listOfAnswers.length, (i) => i)..shuffle()).first;
    correctAnswer = listOfAnswers[correctIndex];
    correctKey = listOfKeys[correctIndex];

  }

  @override
  void dispose() {
    toggleTimer?.cancel();
    super.dispose();
  }

  void onChoiceTap(int index) {
    if (answerLockedIn) return;

    setState(() {
      answerLockedIn = true;
    });

    bool isCorrect = index == correctIndex;

    // Go to next round or results
    Future.delayed(const Duration(seconds: 2), () {
      if (widget.roundCount >= widget.totalRoundCount) {
        Navigator.pushReplacementNamed(context, "/results", arguments: {
          "CORRECT_COUNT": widget.correctCount + (isCorrect ? 1 : 0),
          "TOTAL_ROUND_COUNT": widget.totalRoundCount,
          "HARD_CORE_MODE": widget.hardCoreMode,
        });
      } else {
        if (randomNumberQuestionTypeNext == 5) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => QuizImageQuestionPage(
                roundCount: widget.roundCount + 1,
                totalRoundCount: widget.totalRoundCount,
                correctCount:
                    widget.correctCount + (isCorrect ? 1 : 0),
                hardCoreMode: widget.hardCoreMode,
                randomNumberQuestionType: randomNumberQuestionTypeNext,
              ),
            ),
          );
        } else if (randomNumberQuestionTypeNext > 5) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => QuizHyeongQuestionPage(
              roundCount: widget.roundCount + 1,
              totalRoundCount: widget.totalRoundCount,
              correctCount: widget.correctCount + (isCorrect ? 1 : 0),
              hardCoreMode: widget.hardCoreMode,
              randomNumberQuestionType: randomNumberQuestionTypeNext,
            ),
          ),
        );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => QuizDetailPage(
                roundCount: widget.roundCount + 1,
                totalRoundCount: widget.totalRoundCount,
                correctCount: widget.correctCount + (isCorrect ? 1 : 0),
                hardCoreMode: widget.hardCoreMode,
                randomNumberQuestionType: randomNumberQuestionTypeNext,
              ),
            ),
          );
        }
      }
    });
  }

  @override
Widget build(BuildContext context) {
  final choices = List.generate(4, (index) {
    final isCorrect = index == correctIndex;
    final bgColor = !answerLockedIn
        ? Colors.black
        : isCorrect
            ? Colors.green
            : Colors.red[200];

  final imagePath = toggle ? startImagePaths[index] : imagePaths[index];


    return GestureDetector(
      onTap: () => onChoiceTap(index),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar at the absolute top
            LinearProgressIndicator(
              value: widget.roundCount / widget.totalRoundCount,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
              minHeight: 4,
            ),

            // Remaining content centered in available space
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        listOfQuestions[widget.randomNumberQuestionType],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        correctAnswer,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // 🔑 The 2x2 grid
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          padding: const EdgeInsets.all(8),
                          children: choices,
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 28, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
}
