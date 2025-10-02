// 📄 hangul_page.dart
import 'package:flutter/material.dart';
import 'hangul_overview_page.dart';
import 'hangul_learning_page.dart';

class HangulPage extends StatelessWidget {
  const HangulPage({Key? key}) : super(key: key);

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
              '한글',
              style: TextStyle(fontSize: 50),
            ),
                        const SizedBox(height: 60),
            const Text(
              'Hangul (한글) ist das koreanische Schriftsystem. Es wurde im 15. Jahrhundert von König Sejong entworfen, um das Schreiben für alle Menschen einfacher zu machen. Hangul ist phonetisch — die Zeichen repräsentieren Laute, die zu Silbenblöcken zusammengesetzt werden.',
              style: TextStyle(fontSize: 16),
            ),
              const SizedBox(height: 32),
              _buildBigButton(
                context: context,
                label: 'Interactives Lernen ->',
                color: Colors.black,
                onTap: () => _navigate(context, const HangulLearningPage()),
              ),
              const SizedBox(height: 32),
                _buildBigButton(
                context: context,
                label: 'Überblick',
                color: Colors.black,
                onTap: () => _navigate(context, const HangulOverviewPage()),
              ),
              const SizedBox(height: 100),
                                                                        Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBigButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}
