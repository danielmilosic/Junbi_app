import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// HangulPage
/// Eine übersichtliche, interaktive Seite, die auf Deutsch erklärt,
/// wie das koreanische Schriftsystem (Hangul) aufgebaut ist.


class HangulOverviewPage extends StatelessWidget {
  const HangulOverviewPage({Key? key}) : super(key: key);

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
    _textColor = (preview == '한글' || preview == '도장' || preview == '한국')
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
        width: 40,
        height: 40,
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
                              Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 28, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

          const SizedBox(height: 6),

          // Aufbau
          const Text(
            'Aufbau eines Silbenblocks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ein Silbenblock besteht typischerweise aus drei Bestandteilen: \n• Anfangskonsonant \n• Vokal \n• optionaler Endkonsonant \n\nBeispiele: \n- 가 = ㄱ + ㅏ (ga) \n- 강 = ㄱ + ㅏ + ㅇ (gang)',
            style: TextStyle(fontSize: 16),
          ),

          const Divider(height: 28),

          // Konsonanten
          const Text(
            'Konsonanten',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 600, // maximum width for the grid
                        ),
                        child:_JamoGrid(
            items: [
              _Jamo('ㄱ', 'g', 'wie in "Gang"'),
              _Jamo('ㅋ', 'k', 'wie in "Kampf"'),
              _Jamo('ㄴ', 'n', 'wie in "nein"'),
              _Jamo('ㄷ', 'd', 'wie in "Dudelsack"'),
              _Jamo('ㅌ', 't', 'wie in "tot'),
              _Jamo('ㄹ', 'r', 'zwischen gerolltem r und l'),
              _Jamo('ㅁ', 'm', 'wie in "Maus"'),
              _Jamo('ㅂ', 'b', 'wie in "Baum"'),
              _Jamo('ㅍ', 'p', 'wie in "Po"'),
              _Jamo('ㅅ', 'Sa', 'stimmlos, wie in "hauS", nicht etwa stimmhaft wie in "Sand"'),
              _Jamo('ㅈ', 'j', 'wie in "Dschungel"'),
              _Jamo('ㅊ', 'ch', 'wie in "Tschernobyl"'),
              _Jamo('ㅇ', 'ng', 'wie in "gang", oder stumm am Anfang'),
              _Jamo('ㅎ', 'h', 'wie in "Hut"'),
            ],
          ),),

          const Divider(height: 28),

          // Vokale
          const Text(
            'Vokale',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 600, // maximum width for the grid
                        ),
                        child:_JamoGrid(
            items: [
                _Jamo('ㅏ', 'a', 'wie in "Arm"'),
                _Jamo('ㅓ', 'eo', 'genau zwischen a und o, etwa "å", wie in "Åland"'),
                _Jamo('ㅣ', 'I', 'wie in "Irland"'),
              _Jamo('ㅗ', 'o', 'wie in "oben'),
              _Jamo('ㅜ', 'u', 'wie in "unten"'),
              _Jamo('ㅡ', 'eu', 'Zunge entspannt im Mund, neutraler Laut, nicht wie in "Eule"!'),
              _Jamo('ㅐ', 'ae', 'wie in "schnell"'),
              _Jamo('ㅔ', 'e', 'wie in "schnell'),
            ],
          ),),

          const Divider(height: 28),

          // Zusammensetzung
          const Text(
            'Regeln zur Zusammensetzung',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            '• Die Position des Vokals bestimmt die Form des Blocks: \n\n -  vertikaler Vokal (ㅏ, ㅓ, ㅣ) platziert rechts vom Anfangskonsonanten (ㄱ + ㅏ -> 가) \n  - horizontaler Vokal (ㅗ, ㅜ, ㅡ) platziert unter dem Anfangskonsonanten (ㄱ + ㅗ -> 고) \n\n• Ein weiterer Konsonant am Ende (z. B. ㄱ, ㅁ) wird eventuell darunter hinzugefügt. \n\n• Hangul ist sehr logisch: man lernt zuerst die einzelnen Buchstaben und dann die Blockbildung.',
            style: TextStyle(fontSize: 16),
          ),

          const Divider(height: 28),

          // Beispiele
          const Text(
            'Beispiele',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          _ExampleRow(hangul: '한글', romanization: 'han·geul', meaning: 'Hangul — koreanische Schrift'),
          _ExampleRow(hangul: '한국', romanization: 'han·guk', meaning: 'Korea'),
          _ExampleRow(hangul: '도장', romanization: 'do·jang', meaning: 'Trainingsort für Kampfkunst'),

          const Divider(height: 28),

 
          const SizedBox(height: 8),
          const Text(
            'Schnelle Praxis',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Gebe ein koreanisches Wort oder einen Silbenblock ein und schaue, wie es aussieht.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            readOnly: true, // disable default keyboard
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'z. B. 한글 oder 도장',
            ),
            style: TextStyle(fontSize: 28, color: _textColor),
          ),
          const SizedBox(height: 12),
          Center(child: _buildKeyboard()),

          const Divider(height: 28),

          // Tipps
          const Text(
            'Tipps zum Lernen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            '• Lerne zuerst die 14 grundlegenden Konsonanten und 8 Vokale. \n• Übe die Blockbildung: Konsonant + Vokal (+ optional Konsonant). \n• Höre koreanische Aussprache und sprich mit — viele Laute haben keine exakte deutsche Entsprechung. \n• Schreibe langsam: Man merkt sich die Zeichen leichter, wenn man sie selbst aufschreibt.',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 18),

          // Footer
          Center(
            child: TextButton(
              onPressed: () {
                // optional: open external resource / dictionary
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Weitere Ressourcen können hier verlinkt werden.')),
                );
              },
              child: const Text('Mehr Ressourcen & Übungen'),
            ),
          ),

          const SizedBox(height: 28),

                                        Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 28, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
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
        crossAxisCount: 2,
        childAspectRatio: 1.2,
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
                Text(item.char, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
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
              color: Colors.black,
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
