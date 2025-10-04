import 'package:flutter/material.dart';
import 'package:junbi/hangul_learning_page.dart';

class HangulResultsPage extends StatefulWidget {
  final int level;
  const HangulResultsPage({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<HangulResultsPage> createState() => _HangulResultsPageState();
}

class _HangulResultsPageState extends State<HangulResultsPage> {
  late String congratulationsText;

  @override
  void initState() {
    super.initState();
    congratulationsText = '🎉 Sehr gut! Du hast Level ${widget.level} geschafft! 🎉';
  }

  void _returnToQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HangulLearningPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌸 Subtle Hangul background
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: _buildHangulBackground(),
            ),
          ),

          // Main content
          Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // 🏅 Circle badge
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.deepPurpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '한글',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🎉 Congratulations Text
                    Text(
                      congratulationsText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 🚀 Next Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      onPressed: _returnToQuiz,
                      child: const Text(
                        'Weiter zu den nächsten Levels!',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a subtle background with random Hangul characters.
  Widget _buildHangulBackground() {
    final hangulChars = ['ㄱ','ㄴ','ㄷ','ㄹ','ㅁ','ㅂ','ㅅ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ','ㅏ','ㅓ','ㅗ','ㅜ','ㅡ','ㅣ'];
    final random = hangulChars..shuffle();
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 200,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            random[index % random.length],
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
