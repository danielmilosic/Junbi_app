import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:junbi/results_page.dart';
import 'package:junbi/strings.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'quiz_detail_page.dart';
import 'quiz_image_question_page.dart';

class QuizHyeongQuestionPage extends StatefulWidget {
  final int roundCount;
  final int totalRoundCount;
  final int correctCount;
  final int randomNumberQuestionType;
  final bool hardCoreMode;

  const QuizHyeongQuestionPage({
    super.key,
    this.roundCount = 1,
    required this.totalRoundCount,
    this.correctCount = 0,
    required this.hardCoreMode,
    required this.randomNumberQuestionType,
  });

  @override
  State<QuizHyeongQuestionPage> createState() => _QuizHyeongQuestionPageState();
}

class _QuizHyeongQuestionPageState extends State<QuizHyeongQuestionPage> {
  bool answerLockedIn = false;
  late List<int> randomNumberQuestionTypeList;
  late int randomNumberQuestionTypeNext;
  late List<String> listOfQuestions;
  late List<MapEntry<String, String>> listOfAllAnswers;
  late List<String> listOfAnswers;
  late List<String> listOfKeys;
  late List<String> listOfInfos;

  late int correctIndex;
  String correctAnswer = "";
  String correctKey = "";
  String correctHyeongInfo = "";
  String question = "";
  int? selectedIndex;

    @override
  void initState() {
    super.initState();

    // 1️⃣ Randomize question type for next round
    if (widget.hardCoreMode) {
      randomNumberQuestionTypeList = [0, 1, 2, 5]..shuffle();
    } else {
      randomNumberQuestionTypeList = [0, 2, 5]..shuffle();
    }
    randomNumberQuestionTypeNext = randomNumberQuestionTypeList.first;

    // 2️⃣ Load questions
    listOfQuestions = AppStrings.questions;

    // 3️⃣ Select 4 random hyeong items
    final List<String> hyeongItems = List<String>.from(AppStrings.hyeong_data);

        // Take a limited number of entries depending on level (totalRoundCount)
    final levelDependentEntries = () {
      switch (widget.totalRoundCount) {
        case 10:
          return hyeongItems.take(4).toList();
        case 15:
          return hyeongItems.take(4).toList();
        case 20:
          return hyeongItems.take(6).toList();
        case 25:
          return hyeongItems.take(8).toList();
        case 30:
          return hyeongItems.toList();
        default:
          return hyeongItems;
      }
    }();
    levelDependentEntries.shuffle();
    final List<String> selectedEntries = levelDependentEntries.take(4).toList();

    // 4️⃣ Initialize lists
    listOfAnswers = [];
    listOfInfos = [];
    listOfKeys = [];

    // 5️⃣ Parse selected entries and populate answers/keys
    for (int i = 0; i < selectedEntries.length; i++) {
      final entry = selectedEntries[i];
      final parts = entry.split('|');

      if (widget.randomNumberQuestionType == 6) {
        // Number of movements
        if (parts.length > 5) {
          listOfAnswers.add(parts[4]);
          listOfInfos.add(parts[0]);
          listOfKeys.add(parts[0]);
        }
      } else if (widget.randomNumberQuestionType == 7) {
        // Hyeong Name (German)
        if (parts.length > 5) {
          listOfAnswers.add(parts[0]);
          listOfInfos.add(parts[5]);
          listOfKeys.add(parts[0]);
        }
      } else {
        // Explanation
        if (parts.length > 3) {
          listOfAnswers.add(parts[3]);
          listOfInfos.add(parts[5]);
          listOfKeys.add(parts[0]);
        }
      }
    }

    // 6️⃣ Pick correct answer depending on totalRoundCount
    if (widget.totalRoundCount == 10) {
      // force correct answer to be hyeong_1 or hyeong_2
      int index1 = listOfKeys.indexOf("Cheon Ji");
      int index2 = listOfKeys.indexOf("Dan Gun");
      List<int> options = [index1, index2];
      options.shuffle();
      correctIndex = options.first;

    } else {
      // other totalRoundCount: pick completely random
      correctIndex = (List<int>.generate(listOfAnswers.length, (i) => i)..shuffle()).first;
    }

    correctAnswer = listOfAnswers[correctIndex];
    // 7️⃣ Set question text

    correctHyeongInfo = listOfInfos[correctIndex];
    if (widget.randomNumberQuestionType == 6) {
      question = "${listOfQuestions[widget.randomNumberQuestionType]}$correctHyeongInfo?";
    } else {
      question = "${listOfQuestions[widget.randomNumberQuestionType]}$correctHyeongInfo. Hyeong?";
    }
  }


  void onChoiceTap(int index) {
    if (answerLockedIn) return;

    setState(() {
      selectedIndex = index;
      answerLockedIn = true;
    });

    bool isCorrect = index == correctIndex;

    // Go to next round or results
    Future.delayed(const Duration(seconds: 2), () {
      if (widget.roundCount >= widget.totalRoundCount) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => ResultsPage(
              totalRoundCount: widget.totalRoundCount,
              correctCount: widget.correctCount + (isCorrect ? 1 : 0),
              hardCoreMode: widget.hardCoreMode,
          ),
        ),
      );
      } else {
        if (randomNumberQuestionTypeNext == 5) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
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
          CupertinoPageRoute(
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
            CupertinoPageRoute(
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
      final isTapped = index == selectedIndex;
      Color bgColor;
      if (!answerLockedIn) {
        bgColor = Colors.grey[300]!;
      } else {
        if (isCorrect) {
          bgColor = Colors.green; // Highlight correct answer
        } else if (isTapped && !isCorrect) {
          bgColor = Colors.red[200]!; // Highlight wrong tapped answer in red
        } else {
          bgColor = Colors.grey[300]!; // Non-tapped wrong answers stay black
        }
      }
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
            child: Text(
              listOfAnswers[index],
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
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

        // The rest of the content centered in the remaining space
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
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
        ),
      ],
    ),
  ),
);
  }
}
