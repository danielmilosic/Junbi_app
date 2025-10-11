import 'package:flutter/material.dart';
import 'package:junbi/hangul_learning_page.dart';
import 'hangul_level1_2.dart';
import 'hangul_level1_4.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// HangulPage
/// Eine übersichtliche, interaktive Seite, die auf Deutsch erklärt,
/// wie das koreanische Schriftsystem (Hangul) aufgebaut ist.


class HangulLevel13 extends StatelessWidget {
  const HangulLevel13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: _HangulContent(),
        ),
      ),
    );
  }
}

class _HangulContent extends StatefulWidget {
  const _HangulContent({Key? key}) : super(key: key);

  @override
  State<_HangulContent> createState() => _HangulContentState();
}

class _HangulContentState extends State<_HangulContent> {
  final TextEditingController _controller = TextEditingController();
  String _currentInput = '';

  // Hangul Jamo lists
  final List<String> _fullInitialConsonants = [
    'ㄱ','ㄲ','ㄴ','ㄷ','ㄸ','ㄹ','ㅁ','ㅂ','ㅃ','ㅅ','ㅆ','ㅇ','ㅈ','ㅉ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
  ];
  final List<String> _fullVowels = [
    'ㅏ','ㅐ','ㅑ','ㅒ','ㅓ','ㅔ','ㅕ','ㅖ','ㅗ','ㅘ','ㅙ','ㅚ','ㅛ','ㅜ','ㅝ','ㅞ','ㅟ','ㅠ','ㅡ','ㅢ','ㅣ'
  ];
  final List<String> _fullFinalConsonants = [
    '', 'ㄱ','ㄲ','ㄳ','ㄴ','ㄵ','ㄶ','ㄷ','ㄹ','ㄺ','ㄻ','ㄼ','ㄽ','ㄾ','ㄿ','ㅀ','ㅁ','ㅂ','ㅄ','ㅅ','ㅆ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
  ];


  final List<int> _uiInitialIndexes = [0, 2, 3, 5, 6, 7];
  final List<int> _uiVowelIndexes = [0, 4, 8, 13, 18, 20];
  final List<int> _uiFinalIndexes = [1, 4, 7, 8, 16, 17];

  int? _initialIndex;
  int? _vowelIndex;
  int? _finalIndex;
  Color _textColor = Colors.white;
  

  List<String> get initials =>
      _uiInitialIndexes.map((i) => _fullInitialConsonants[i]).toList();
  List<String> get vowels =>
      _uiVowelIndexes.map((i) => _fullVowels[i]).toList();

  void _pressKey(String key) {
    if (initials.contains(key)) {
      _pressConsonant(key);
    } else if (vowels.contains(key)) {
      _pressVowel(key);
    }
  }

  void _pressConsonant(String c) {
    final index = _fullInitialConsonants.indexOf(c);


    // Case 1: Starting new syllable
    if (_initialIndex == null) {
      _initialIndex = index;
      _updateController();
      return;
    }

    // Case 2: Initial exists but no vowel yet → replace initial (user typed new consonant)
    if (_vowelIndex == null) {
      _initialIndex = index;
      _updateController();
      return;


    }

    // Case 3: We have initial + vowel, so this consonant might be a final
    final finalCandidate = _fullFinalConsonants.indexOf(c);
    if (finalCandidate != -1 && _finalIndex == null) {
      _finalIndex = finalCandidate;
      _updateController();
      return;
    }

    // Default: commit current syllable, start new one
    _commitSyllable();
    _initialIndex = index;
    _updateController();
  }

  void _pressVowel(String v) {
    final vIndex = _fullVowels.indexOf(v);


    // Case 0: Starting new syllable
    if (_finalIndex != null) {
      int? finalToInitial(int finalIndex) {
        String f = _fullFinalConsonants[finalIndex];
        int i = _fullInitialConsonants.indexOf(f);
        return (i != -1) ? i : null;
      }
      int? newInitialIndex = finalToInitial(_finalIndex!);
      _finalIndex = null;
      _commitSyllable();
      _initialIndex = newInitialIndex;
      _vowelIndex = vIndex;
      _updateController();
      return;
    }

    // If no initial yet, auto insert ㅇ
    if (_initialIndex == null) {
      _initialIndex = _fullInitialConsonants.indexOf('ㅇ');
    }

    // If we already had a vowel + final, commit and start new syllable
    if (_vowelIndex != null) {
      _commitSyllable();
    }

    _vowelIndex = vIndex;
    _finalIndex = null;
    _updateController();
  }

  void _commitSyllable() {
    if (_initialIndex == null) return;

    final initial = _initialIndex!;
    final vowel = _vowelIndex ?? 0;
    final fin = _finalIndex ?? 0;

    final syllable = String.fromCharCode(
      0xAC00 + (initial * 21 + vowel) * 28 + fin,
    );

    _currentInput += syllable;

    _initialIndex = null;
    _vowelIndex = null;
    _finalIndex = null;
    _updateController();
  }

  void _updateController() {
    String preview = _currentInput;

    if (_initialIndex != null) {
      preview += _fullInitialConsonants[_initialIndex!];
    }
    if (_vowelIndex != null) {
      final combined = String.fromCharCode(
        0xAC00 + (_initialIndex! * 21 + _vowelIndex!) * 28,
      );
      preview = _currentInput + combined;
    }
    if (_finalIndex != null) {
      final combined = String.fromCharCode(
        0xAC00 + (_initialIndex! * 21 + _vowelIndex!) * 28 + _finalIndex!,
      );
      preview = _currentInput + combined;
    }
  setState(() {
    _textColor = (preview == '둘' || preview == '막기' || preview == '그만' || preview == '만두')
        ? Colors.green
        : Colors.white;


    _controller.text = preview;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  });
}

  void _backspace() {
    if (_finalIndex != null) {
      _finalIndex = null;
    } else if (_vowelIndex != null) {
      _vowelIndex = null;
    } else if (_initialIndex != null) {
      _initialIndex = null;
    } else if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
    }
    _updateController();
  }

  Widget _buildKey(String label) {
    return GestureDetector(
      onTap: () => _pressKey(label),
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: initials.map(_buildKey).toList(),
        ),
        const SizedBox(height: 6),
        Wrap(
          alignment: WrapAlignment.center,
          children: vowels.map(_buildKey).toList(),
        ),
        const SizedBox(height: 6),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            GestureDetector(
              onTap: _backspace,
              child: Container(
                width: 50,
                height: 38,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: const Icon(Icons.backspace, size: 24),
              ),
            ),
          ],
        ),
      ],
    );
  }
  void _markCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('level1completed', true);  // mark level 1 as completed
}
  Widget _buildAudioCard(BuildContext context, String text, String audioFile) {
    final AudioPlayer audioPlayer = AudioPlayer();
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, size: 20, color: Colors.white),
              onPressed: () async {
                try {
                  final audioPath = audioFile;
                  await audioPlayer.play(AssetSource(audioPath));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Audio not available')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                  // Progress bar at the absolute top
        LinearProgressIndicator(
          value: 4 / 5,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 4,
        ),

          const SizedBox(height: 30),

          // Aufbau
          const Text(
            'Endkonsonanten',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Eine Silbe kann mit einem Vokal enden, aber es ist auch möglich noch einen Konsonanten anzuhängen. Ein Konsonant wird am Ende meist etwas anders ausgesprochen, oft härter. \n Beispiele: \n- 곡 = ㄱ + ㅗ + ㄱ (gok) \n- 길 = ㄱ + ㅣ + ㄹ (gil) ',
            style: TextStyle(fontSize: 16),
          ),



          const Divider(height: 28),

          const SizedBox(height: 8),
          const Text(
            'Übung',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Du kannst schon folgende Wörter auf Koreanisch schreiben:',
            style: TextStyle(fontSize: 16),
          ),

SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      _buildAudioCard(context, '둘 - zwei', 'audio/hangul/dul.mp3'),
      _buildAudioCard(context, '막기 - Block', 'audio/hangul/makgi.mp3'),
      _buildAudioCard(context, '그만 - Stop', 'audio/geuman.mp3'),
      _buildAudioCard(context, '만두 - Mandu (Teigtasche)', 'audio/hangul/mandu.mp3'),
    ],
  ),
),

          const Text(
            'Probiere es aus!',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            readOnly: true, // disable default keyboard
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '',
            ),
            style: TextStyle(fontSize: 28, color: _textColor),
          ),
          const SizedBox(height: 12),
          Center(child: _buildKeyboard()),

          Padding(
            padding: const EdgeInsets.only(bottom:8.0, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                  onPressed: () {
                    // Navigate forward
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HangulLevel12()), // or MainPage()
                      (route) => false, // remove all previous routes
                    );
                  },
                ),

                // Home button
                IconButton(
                  icon: const Icon(Icons.home, size: 28, color: Colors.white),
                    onPressed: () {
                    // Navigate forward
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HangulLearningPage()), // or MainPage()
                      (route) => false, // remove all previous routes
                    );
                  }, // or Navigator.popUntil
                ),

                // Forward button
                IconButton(
                  icon: const Icon(Icons.arrow_forward, size: 28, color: Colors.white),
                  onPressed: () {
                    _markCompleted();
                    // Navigate forward
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HangulLevel14()), // or MainPage()
                      (route) => false, // remove all previous routes
                    );
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}


class _JamoGrid extends StatelessWidget {
  final List<_Jamo> items;
  const _JamoGrid({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: Colors.black,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Row(
              children: [
                Text(item.char, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.roman, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(item.note, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Jamo {
  final String char;
  final String roman;
  final String note;
  _Jamo(this.char, this.roman, this.note);
}

class _ExampleRow extends StatelessWidget {
  final String hangul;
  final String romanization;
  final String meaning;

  const _ExampleRow({Key? key, required this.hangul, required this.romanization, required this.meaning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(hangul, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(romanization, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(meaning),
              ],
            ),
          )
        ],
      ),
    );
  }
}
