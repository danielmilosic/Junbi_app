import 'package:flutter/material.dart';

class HangulPage extends StatelessWidget {
  const HangulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangul (형)'),
      ),
      body: const Center(
        child: Text(
          'This is the Hangul page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
