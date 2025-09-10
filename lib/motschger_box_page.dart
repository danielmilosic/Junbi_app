import 'package:flutter/material.dart';

class MotschgerBoxPage extends StatelessWidget {
  const MotschgerBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MotschgerBoxPage (형)'),
      ),
      body: const Center(
        child: Text(
          'This is the MotschgerBoxPage page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
