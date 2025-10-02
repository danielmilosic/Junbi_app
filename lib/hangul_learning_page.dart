// 📄 hangul_page.dart
import 'package:flutter/material.dart';
import 'hangul_overview_page.dart';
import 'hangul_learning_page.dart';
import 'hangul_levels/level1/hangul_level1_0.dart';
import 'hangul_levels/level2/hangul_level2_0.dart';
import 'package:junbi/main.dart';

class HangulLearningPage extends StatelessWidget {
  const HangulLearningPage({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                          const SizedBox(height: 6),
              const Text(
                'Hier kannst du interaktiv Hangul lernen.',
                style: TextStyle(fontSize: 16),
              ),
                const SizedBox(height: 32),
                _buildBigButton(
                  context: context,
                  label: 'Level 1: 가나다',
                  color: Colors.black,
                  onTap: () => _navigate(context, const HangulLevel10()),
                ),
                const SizedBox(height: 32),
                  _buildBigButton(
                  context: context,
                  label: 'Level 2: 쌍팔목막기',
                  color: Colors.black,
                  onTap: () => _navigate(context, const HangulLevel20()),
                ),
                              const SizedBox(height: 32),
                  _buildBigButton(
                  context: context,
                  label: 'Level 3: 안녕하세요',
                  color: Colors.black,
                  onTap: () => _navigate(context, const HangulOverviewPage()),
                ),
                              const SizedBox(height: 32),
                  _buildBigButton(
                  context: context,
                  label: 'Level 4: 태권도',
                  color: Colors.black,
                  onTap: () => _navigate(context, const HangulOverviewPage()),
                ),
                              const SizedBox(height: 32),
                  _buildBigButton(
                  context: context,
                  label: 'Level 5: 차렷, 경례',
                  color: Colors.black,
                  onTap: () => _navigate(context, const HangulOverviewPage()),
                ),
                                                                          Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                                  onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => JunbiApp()), // or MainPage()
                    (route) => false, // remove all previous routes
                  );
                },
                ),
              ),
              ],
            ),
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
