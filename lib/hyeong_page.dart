import 'package:flutter/material.dart';

class HyeongPage extends StatelessWidget {
  const HyeongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyeong (형)'),
      ),
      body: const Center(
        child: Text(
          'This is the Hyeong page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
