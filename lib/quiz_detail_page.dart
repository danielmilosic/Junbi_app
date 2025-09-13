import 'dart:async';
import 'package:flutter/material.dart';
import 'package:junbi/strings.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'quiz_image_question_page.dart';
import 'quiz_hyeong_question_page.dart';


class QuizDetailPage extends StatefulWidget {
  final int roundCount;
  final int totalRoundCount;
  final int correctCount;
  final int randomNumberQuestionType;
  final bool hardCoreMode;

  const QuizDetailPage({
    super.key,
    this.roundCount=0,
    required this.totalRoundCount,
    this.correctCount = 0,
    required this.hardCoreMode,
    required this.randomNumberQuestionType
  });

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  bool answerLockedIn = false;
  late List<int> randomNumberQuestionTypeList;
  late int randomNumberQuestionTypeNext;
  late List<String> listOfQuestions;
  late List<MapEntry<String, String>> listOfAllAnswers;
  late List<String> listOfAnswers; 
  late List<String> listOfKeys; 
  late Map<String, List<String>> listOfAllTechniques;

  late int correctIndex;
  String correctAnswer = "";
  String correctKey = "";
  Timer? toggleTimer;
  bool toggle = false;

  late String imagePath;
  bool hasStartImage = false;


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
      randomNumberQuestionTypeList =
          [0, 1, 2, 3, 5, 6, 7, 8]..shuffle(); // exclude "4"
    } else {
      randomNumberQuestionTypeList =
          [0, 2, 3, 5, 6, 7, 8]..shuffle(); // exclude "1" and "4"
    }
    randomNumberQuestionTypeNext = randomNumberQuestionTypeList.first;
    listOfQuestions = AppStrings.questions;

    // Map of key -> value for the selected question type
    final allEntries = AppStrings.techniqueInformation.entries
        .map((entry) => MapEntry(entry.key, entry.value[widget.randomNumberQuestionType]))
        .toList();

    List<MapEntry<String, String>> selectedEntries;

    if (widget.randomNumberQuestionType == 3) {
      // Ensure unique values
      final seenValues = <String>{};
      selectedEntries = [];

      allEntries.shuffle(); // randomize order
      for (var entry in allEntries) {
        if (!seenValues.contains(entry.value)) {
          seenValues.add(entry.value);
          selectedEntries.add(entry);
        }
        if (selectedEntries.length >= 4) break;
      }
    } else {
      // Just pick first 4
      allEntries.shuffle();
      selectedEntries = allEntries.take(4).toList();
    }

    // Separate keys and answers
    listOfKeys = selectedEntries.map((e) => e.key).toList();
    listOfAnswers = selectedEntries.map((e) => e.value).toList();


    // Start image toggling every second
    toggleTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        toggle = !toggle;
      });
    });

    // Example: random correct answer index
    correctIndex = (List<int>.generate(listOfAnswers.length, (i) => i)..shuffle()).first;
    correctAnswer = listOfAnswers[correctIndex];
    correctKey = listOfKeys[correctIndex];

    imagePath = "assets/images/$correctKey.png";


    String startPath = "assets/images/${correctKey}_start.png";
    assetExists(startPath).then((exists) {
      if (exists) {
        setState(() {
          hasStartImage = true;
          imagePath = startPath;
        });
      }
    });
  
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
            correctCount: widget.correctCount + (isCorrect ? 1 : 0),
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
          ? Colors.grey[300]
          : isCorrect
              ? Colors.green
              : Colors.grey[300];

      return GestureDetector(
        onTap: () => onChoiceTap(index),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(listOfAnswers[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
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

            // Remaining content centered
            Expanded(
              child: Center(
                child: SingleChildScrollView(
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
                      const SizedBox(height: 20),

                      Image.asset(
                        toggle ? "assets/images/$correctKey.png" : imagePath,
                        height: 200,
                      ),

                      const SizedBox(height: 20),
                      ...choices,

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
