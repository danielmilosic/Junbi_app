import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatisticsPage (형)'),
      ),
      body: const Center(
        child: Text(
          'This is the StatisticsPage page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
