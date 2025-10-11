import 'package:flutter/material.dart';

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
  final List<String> initialConsonants = [
    'ㄱ','ㄲ','ㄴ','ㄷ','ㄸ','ㄹ','ㅁ','ㅂ','ㅃ','ㅅ','ㅆ','ㅇ','ㅈ','ㅉ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
  ];
  final List<String> vowels = [
    'ㅏ','ㅐ','ㅑ','ㅒ','ㅓ','ㅔ','ㅕ','ㅖ','ㅗ','ㅘ','ㅙ','ㅚ','ㅛ','ㅜ','ㅝ','ㅞ','ㅟ','ㅠ','ㅡ','ㅢ','ㅣ'
  ];
  final List<String> finalConsonants = [
    '', 'ㄱ','ㄲ','ㄳ','ㄴ','ㄵ','ㄶ','ㄷ','ㄹ','ㄺ','ㄻ','ㄼ','ㄽ','ㄾ','ㄿ','ㅀ','ㅁ','ㅂ','ㅄ','ㅅ','ㅆ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
  ];

  // buffer for currently composed syllable
  int? _initialIndex;
  int? _vowelIndex;
  int? _finalIndex;

  void _pressInitial(String c) {
    if (_vowelIndex != null && _initialIndex != null) {
      // syllable complete: append to current input
      _commitSyllable();
    }
    _initialIndex = initialConsonants.indexOf(c);
    _vowelIndex = null;
    _finalIndex = null;
    _updateController();
  }

  void _pressVowel(String v) {
    _vowelIndex = vowels.indexOf(v);
    _finalIndex = null;
    _updateController();
  }

  void _pressFinal(String f) {
    if (_initialIndex != null && _vowelIndex != null) {
      _finalIndex = finalConsonants.indexOf(f);
      _commitSyllable();
    }
  }

  void _commitSyllable() {
    if (_initialIndex == null || _vowelIndex == null) return;

    final syllable = String.fromCharCode(
      0xAC00 + (_initialIndex! * 21 + _vowelIndex!) * 28 + (_finalIndex ?? 0)
    );

    _currentInput += syllable;
    _initialIndex = null;
    _vowelIndex = null;
    _finalIndex = null;

    _updateController();
  }

  void _backspace() {
    if (_vowelIndex != null || _initialIndex != null) {
      _initialIndex = null;
      _vowelIndex = null;
      _finalIndex = null;
    } else if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
    }
    _updateController();
  }

  void _updateController() {
    String preview = _currentInput;
    if (_initialIndex != null) {
      // show initial consonant before vowel
      preview += initialConsonants[_initialIndex!];
    }
    if (_vowelIndex != null) {
      // combine initial + vowel for preview
      final combined = String.fromCharCode(
        0xAC00 + (_initialIndex! * 21 + _vowelIndex!) * 28
      );
      preview = _currentInput + combined;
    }
    _controller.text = preview;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        const Text('Anfangskonsonanten', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 4,
          children: initialConsonants.map((c) => ElevatedButton(
            onPressed: () => _pressInitial(c),
            child: Text(c, style: const TextStyle(fontSize: 20)),
          )).toList(),
        ),
        const SizedBox(height: 8),
        const Text('Vokale', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 4,
          children: vowels.map((v) => ElevatedButton(
            onPressed: () => _pressVowel(v),
            child: Text(v, style: const TextStyle(fontSize: 20)),
          )).toList(),
        ),
        const SizedBox(height: 8),
        const Text('Endkonsonanten', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 4,
          children: finalConsonants.map((f) => ElevatedButton(
            onPressed: () => _pressFinal(f),
            child: Text(f == '' ? '–' : f, style: const TextStyle(fontSize: 20)),
          )).toList(),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _backspace,
          icon: const Icon(Icons.backspace),
          label: const Text('Löschen'),
        ),
      ],
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
          _JamoGrid(
            items: [
              _Jamo('ㄱ', 'g/k', 'g wie in "go" bzw. k am Wortanfang'),
              _Jamo('ㄴ', 'n', 'n wie in "no"'),
              _Jamo('ㄷ', 'd/t', 'd wie in "do"'),
              _Jamo('ㄹ', 'r/l', 'r zwischen r und l (z. B. Rolllaut)'),
              _Jamo('ㅁ', 'm', 'm wie in "me"'),
              _Jamo('ㅂ', 'b/p', 'b wie in "be"'),
              _Jamo('ㅅ', 's', 's wie in "see" (vor i/ya -> schärfer)'),
              _Jamo('ㅇ', 'ng / silent', 'stumm am Silbenanfang, ng am Ende'),
              _Jamo('ㅎ', 'h', 'h wie in "ha"'),
            ],
          ),

          const Divider(height: 28),

          // Vokale
          const Text(
            'Vokale',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          _JamoGrid(
            items: [
              _Jamo('ㅏ', 'a', 'a wie in "Vater"'),
              _Jamo('ㅓ', 'eo', 'ähnlich wie o in "son" — kein deutsches Äquivalent'),
              _Jamo('ㅗ', 'o', 'o wie in "oh"'),
              _Jamo('ㅜ', 'u', 'u wie in "u"'),
              _Jamo('ㅡ', 'eu', 'zwischen u und ɯ — nicht im Deutschen'),
              _Jamo('ㅣ', 'i', 'i wie in "wie"'),
              _Jamo('ㅐ', 'ae', 'e wie in "Mann" (leicht)'),
              _Jamo('ㅔ', 'e', 'e wie in "See" (leicht)')
            ],
          ),

          const Divider(height: 28),

          // Zusammensetzung
          const Text(
            'Regeln zur Zusammensetzung',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            '• Die Position des Vokals bestimmt die Form des Blocks: \n- vertikaler Vokal (ㅏ, ㅓ, ㅣ) platziert rechts vom Anfangskonsonanten (ㄱ + ㅏ -> 가) \n- horizontaler Vokal (ㅗ, ㅜ, ㅡ) platziert unter dem Anfangskonsonanten (ㄱ + ㅗ -> 고) \n\n• Mehrere Konsonanten am Ende (z. B. ㄺ, ㄶ) werden als zusammengesetzte Jongseong dargestellt. \n• Hangul ist sehr logisch: man lernt zuerst Jamo (Einzelzeichen) und dann die Blockbildung.',
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
              hintText: 'z. B. 한글 oder 사랑',
            ),
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 12),
          _buildKeyboard(),

          const Divider(height: 28),

          // Tipps
          const Text(
            'Tipps zum Lernen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            '• Lerne zuerst die 14 grundlegenden Konsonanten und 10 Vokale. \n• Übe die Blockbildung: konsonant + vokal (+ optional konsonant). \n• Höre koreanische Aussprache und sprich mit — viele Laute haben keine exakte deutsche Entsprechung. \n• Schreibe langsam: Hangul ist logisch und schnell zu lernen, wenn man die Regeln versteht.',
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
        childAspectRatio: 1.3,
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
