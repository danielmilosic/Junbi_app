import 'package:flutter/material.dart';
import 'package:junbi/hangul_learning_page.dart';
//import 'hangul_level4_1.dart';
import 'package:audioplayers/audioplayers.dart';

/// HangulPage
/// Eine übersichtliche, interaktive Seite, die auf Deutsch erklärt,
/// wie das koreanische Schriftsystem (Hangul) aufgebaut ist.


class HangulLevel40 extends StatelessWidget {
  const HangulLevel40({Key? key}) : super(key: key);

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

  final List<int> _uiInitialIndexes = [0, 2, 3, 5, 6, 7, 9, 11, 12, 14, 15, 16, 17, 18];
  //final List<int> _uiInitialIndexes = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
  final List<int> _uiVowelIndexes = [0, 1, 4, 5, 8, 13, 18, 20];

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

  // Map of single → double consonants
  const Map<String, String> doubleConsonantMap = {
    'ㄱ': 'ㄲ',
    'ㄷ': 'ㄸ',
    'ㅂ': 'ㅃ',
    'ㅅ': 'ㅆ',
    'ㅈ': 'ㅉ',
  };

    // Map for final double/mixed consonants
  const Map<String, String> doubleFinalMap = {
    'ㄱㅅ': 'ㄳ',
    'ㄴㅈ': 'ㄵ',
    'ㄴㅎ': 'ㄶ',
    'ㄹㄱ': 'ㄺ',
    'ㄹㅁ': 'ㄻ',
    'ㄹㅂ': 'ㄼ',
    'ㄹㅅ': 'ㄽ',
    'ㄹㅌ': 'ㄾ',
    'ㄹㅍ': 'ㄿ',
    'ㄹㅎ': 'ㅀ',
    'ㅂㅅ': 'ㅄ',
    'ㅅㅅ': 'ㅆ',
    'ㄱㄱ': 'ㄲ',
    'ㄷㄷ': 'ㄸ',
    'ㅂㅂ': 'ㅃ',
    'ㅈㅈ': 'ㅉ',
  };

  // Case 0: Double consonant detection before anything else
  if (_vowelIndex == null && _initialIndex != null) {
    String currentInitial = _fullInitialConsonants[_initialIndex!];
    if (currentInitial == c && doubleConsonantMap.containsKey(c)) {
      // Upgrade to double consonant
      String doubleC = doubleConsonantMap[c]!;
      _initialIndex = _fullInitialConsonants.indexOf(doubleC);
      _updateController();
      return;
    }
  }

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

    // Case 4: Final double/mixed consonant detection
  if (_vowelIndex != null && _finalIndex != null) {
    String existingFinal = _fullFinalConsonants[_finalIndex!];
    String comboKey = '$existingFinal$c';

    if (doubleFinalMap.containsKey(comboKey)) {
      String newFinal = doubleFinalMap[comboKey]!;
      int newFinalIndex = _fullFinalConsonants.indexOf(newFinal);
      if (newFinalIndex != -1) {
        _finalIndex = newFinalIndex;
        _updateController();
        return;
      }
    }
  }

  // Default: commit current syllable, start new one
  _commitSyllable();
  _initialIndex = index;
  _updateController();
}

void _pressVowel(String v) {
  final vIndex = _fullVowels.indexOf(v);

  // Map of single → double consonants
  const Map<String, String> doubleVowelMap = {
    'ㅏ': 'ㅑ',
    'ㅓ': 'ㅕ',
    'ㅗ': 'ㅛ',
    'ㅜ': 'ㅠ',
    'ㅐ': 'ㅒ',
    'ㅔ': 'ㅖ',
  };

  // Map to split double/mixed vowels into [main, tail]
  const Map<String, String> CombinedVowelMap = {
    'ㅗㅏ':'ㅘ',
    'ㅗㅐ':'ㅙ',
    'ㅗㅣ':'ㅚ',
    'ㅜㅓ':'ㅝ',
    'ㅜㅣ':'ㅟ',
    'ㅜㅔ':'ㅞ',
    'ㅡㅣ':'ㅢ',
  };

  // Map to split double/mixed final consonants into [main, tail]
  const Map<String, List<String>> finalSplitMap = {
    'ㄳ': ['ㄱ', 'ㅅ'],
    'ㄵ': ['ㄴ', 'ㅈ'],
    'ㄶ': ['ㄴ', 'ㅎ'],
    'ㄺ': ['ㄹ', 'ㄱ'],
    'ㄻ': ['ㄹ', 'ㅁ'],
    'ㄼ': ['ㄹ', 'ㅂ'],
    'ㄽ': ['ㄹ', 'ㅅ'],
    'ㄾ': ['ㄹ', 'ㅌ'],
    'ㄿ': ['ㄹ', 'ㅍ'],
    'ㅀ': ['ㄹ', 'ㅎ'],
    'ㅄ': ['ㅂ', 'ㅅ'],
    'ㅆ': ['ㅅ', 'ㅅ'], 
    'ㄲ': ['ㄱ', 'ㄱ'],
    'ㄸ': ['ㄷ', 'ㄷ'],
    'ㅃ': ['ㅂ', 'ㅂ'],
    'ㅉ': ['ㅈ', 'ㅈ'],
  };


  // Case 0.5: Double vowel detection before anything else
  if (_vowelIndex != null && _initialIndex != null && _finalIndex == null) {
    String currentVowel = _fullVowels[_vowelIndex!];
    if (currentVowel == v && doubleVowelMap.containsKey(v)) {
      // Upgrade to double consonant
      String doubleV = doubleVowelMap[v]!;
      _vowelIndex = _fullVowels.indexOf(doubleV);
      _updateController();
      return;
    }
    else {
      String comboKey = '$currentVowel$v';
      if (CombinedVowelMap.containsKey(comboKey)) {
        String newVowel = CombinedVowelMap[comboKey]!;
        _vowelIndex = _fullVowels.indexOf(newVowel);
        _updateController();
        return;
        }
    }
  }

  // Case 0: If there is a final consonant, we may need to split it
  if (_finalIndex != null) {
    String finalChar = _fullFinalConsonants[_finalIndex!];

    if (finalSplitMap.containsKey(finalChar)) {
      // 🪄 Split final cluster into (main, tail)
      var parts = finalSplitMap[finalChar]!;
      String mainPart = parts[0];
      String tailPart = parts[1];

      // 1️⃣ Commit previous syllable with only the "main" final
      _finalIndex = _fullFinalConsonants.indexOf(mainPart);
      _commitSyllable();

      // 2️⃣ Set "tail" as the new initial for the next syllable
      int tailIndex = _fullInitialConsonants.indexOf(tailPart);
      _initialIndex = (tailIndex != -1) ? tailIndex : null;
      _vowelIndex = vIndex;
      _updateController();
      return;
    } else {
      // Simple final: convert to initial if possible
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
    _textColor = (preview == '태권도' || preview == '화랑' || preview == '광계' || preview == '리권대리기' || preview == '정 관수 들기')
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
          value: 1 / 5,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 4,
        ),

          const SizedBox(height: 30),

          // Aufbau
          const Text(
            'Zwielaute',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Jetzt lernst du endlich, wie man Taekwondo auf Koreanisch schreibt! \n\nManche Vokale können zu Zwielauten kombiniert werden. Deren Aussprache ist aber nicht immer leicht. Deswegen geht es in diesem gesamten Level nur um Zwielaute!\n\nWir fangen mit zwei einfachen Lauten an: \n\n"ㅗ" + "ㅏ" = "ㅘ" \n\n"ㅜ" + "ㅓ" = "ㅝ"  ',
            style: TextStyle(fontSize: 16),
          ),



          const Divider(height: 28),

          const SizedBox(height: 8),


                    // Konsonanten
          const Text(
            'Neue Vokale',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          _JamoGrid(
            items: [
              _Jamo('ㅘ', 'wa', 'wie in "qUAl"', 'audio/hangul/wa.mp3'),
              _Jamo('ㅝ', 'weo', 'wie im Englischen "WAr"', 'audio/hangul/weo.mp3'),
            ],
          ),


          const Divider(height: 28),

          const SizedBox(height: 8),

          const Text(
            'Beispiele',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Versuche die Beispiele nachzuschreiben. Achte darauf, die beiden Laute nicht zu verwechseln!',
            style: TextStyle(fontSize: 16),
          ),

SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      _buildAudioCard(context, '태권도', 'audio/hangul/taekwondo.mp3'),
      _buildAudioCard(context, '화랑', 'audio/hwa_rang.mp3'),
      _buildAudioCard(context, '광계', 'audio/gwang_gye.mp3'),
      _buildAudioCard(context, '리권 대리기', 'audio/rigwon_daerigi.mp3'),
      _buildAudioCard(context, '정 관수 들기', 'audio/jeong_gwansu_deulgi.mp3'),
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
                      MaterialPageRoute(builder: (_) => HangulLearningPage()), // or MainPage()
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
                    // Navigate forward
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HangulLevel40()), // or MainPage()
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
  _JamoGrid({Key? key, required this.items}) : super(key: key);
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
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
                
                IconButton(
              icon: const Icon(Icons.volume_up, size: 20, color: Colors.white),
              onPressed: () async {
                try {
                  final audioPath = item.audioPath;
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
      },
    );
  }
}

class _Jamo {
  final String char;
  final String roman;
  final String note;
  final String audioPath;
  _Jamo(this.char, this.roman, this.note, this.audioPath);
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
