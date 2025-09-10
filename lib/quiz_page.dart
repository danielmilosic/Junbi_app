import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizPage (형)'),
      ),
      body: const Center(
        child: Text(
          'This is the QuizPage page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
