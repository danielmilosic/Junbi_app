import 'package:flutter/material.dart';

class TechniquesPage extends StatelessWidget {
  const TechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechniquesPage (형)'),
      ),
      body: const Center(
        child: Text(
          'This is the TechniquesPage page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
