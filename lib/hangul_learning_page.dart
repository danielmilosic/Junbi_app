import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hangul_levels/level1/hangul_level1_0.dart';
import 'hangul_levels/level2/hangul_level2_0.dart';
import 'hangul_levels/level3/hangul_level3_0.dart';
import 'hangul_levels/level4/hangul_level4_0.dart';
import 'hangul_levels/level5/hangul_level5_0.dart';
import 'package:junbi/main.dart';

class HangulLearningPage extends StatefulWidget {
  const HangulLearningPage({Key? key}) : super(key: key);

  @override
  State<HangulLearningPage> createState() => _HangulLearningPageState();
}

class _HangulLearningPageState extends State<HangulLearningPage> {
  Map<String, bool> visited = {};
  Map<String, bool> completed = {};

  @override
  void initState() {
    super.initState();
    _loadVisited();
    _loadCompleted();
  }

  Future<void> _loadVisited() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      visited = {
        'level1': prefs.getBool('level1') ?? false,
        'level2': prefs.getBool('level2') ?? false,
        'level3': prefs.getBool('level3') ?? false,
        'level4': prefs.getBool('level4') ?? false,
        'level5': prefs.getBool('level5') ?? false,
      };
    });
  }

    Future<void> _loadCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completed = {
        'level1completed': prefs.getBool('level1completed') ?? false,
        'level2completed': prefs.getBool('level2completed') ?? false,
        'level3completed': prefs.getBool('level3completed') ?? false,
        'level4completed': prefs.getBool('level4completed') ?? false,
        'level5completed': prefs.getBool('level5completed') ?? false,
      };
    });
  }

  Future<void> _markVisited(String levelKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(levelKey, true);
    setState(() {
      visited[levelKey] = true;
    });
  }

  void _navigate(BuildContext context, Widget page, String levelKey) {
    _markVisited(levelKey); // mark as visited
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
                  'Hangul ist relativ leicht zu lernen. Aufgeteilt auf 5 Levels kannst du dir die koreanische Schrift interaktiv aneignen. Nach Level 3 kannst du schon das meiste lesen! Level 4 führt noch ein paar besondere Doppellaute ein und Level 5 verfeinert deine Aussprache. Viel Spaß! :)',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                _buildBigButton(
                  context: context,
                  label: 'Level 1: 가나다',
                  color: Colors.black,
                  visited: visited['level1'] ?? false,
                  completed: completed['level1completed'] ?? false,
                  onTap: () => _navigate(context, const HangulLevel10(), 'level1'),
                ),
                const SizedBox(height: 32),
                _buildBigButton(
                  context: context,
                  label: 'Level 2: 쌍팔목막기',
                  color: Colors.black,
                  visited: visited['level2'] ?? false,
                  completed: completed['level2completed'] ?? false,
                  onTap: () => _navigate(context, const HangulLevel20(), 'level2'),
                ),
                const SizedBox(height: 32),
                _buildBigButton(
                  context: context,
                  label: 'Level 3: 안녕하세요',
                  color: Colors.black,
                  visited: visited['level3'] ?? false,
                  completed: completed['level3completed'] ?? false,
                  onTap: () => _navigate(context, const HangulLevel30(), 'level3'),
                ),
                const SizedBox(height: 32),
                _buildBigButton(
                  context: context,
                  label: 'Level 4: 태권도',
                  color: Colors.black,
                  visited: visited['level4'] ?? false,
                  completed: completed['level4completed'] ?? false,
                  onTap: () => _navigate(context, const HangulLevel40(), 'level4'),
                ),
                const SizedBox(height: 32),
                _buildBigButton(
                  context: context,
                  label: 'Level 5: 차렷, 경례',
                  color: Colors.black,
                  visited: visited['level5'] ?? false,
                  completed: completed['level5completed'] ?? false,
                  onTap: () => _navigate(context, const HangulLevel50(), 'level5'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => JunbiApp()),
                        (route) => false,
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
    bool visited = false,
    bool completed = false,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            if (visited && !completed)
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.check_circle, color: Colors.orange, size: 28)
              ),
            if (completed)
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.check_circle, color: Colors.green, size: 28),
              )
          ],
        ),
      ),
    );
  }
}
