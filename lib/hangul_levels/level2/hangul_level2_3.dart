import 'package:flutter/material.dart';
import 'package:junbi/hangul_learning_page.dart';
import 'hangul_level2_2.dart';
import 'hangul_level2_4.dart';
import 'package:audioplayers/audioplayers.dart';

/// HangulPage
/// Eine übersichtliche, interaktive Seite, die auf Deutsch erklärt,
/// wie das koreanische Schriftsystem (Hangul) aufgebaut ist.


class HangulLevel23 extends StatelessWidget {
  const HangulLevel23({Key? key}) : super(key: key);

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
  final List<int> _uiVowelIndexes = [0, 1, 4, 5, 8, 13, 18, 20];
  final List<int> _uiFinalIndexes = [1, 4, 7, 8, 16, 17, 19, 21, 22, 23, 24, 25, 26, 27];

  List<String> get initialConsonants =>
      _uiInitialIndexes.map((i) => _fullInitialConsonants[i]).toList();

  List<String> get vowels =>
      _uiVowelIndexes.map((i) => _fullVowels[i]).toList();

  List<String> get finalConsonants =>
      _uiFinalIndexes.map((i) => _fullFinalConsonants[i]).toList();

  // buffer for currently composed syllable
  int? _initialIndex;
  int? _vowelIndex;
  int? _finalIndex;

void _pressInitial(String c) {
  // Commit the current syllable if any vowel exists (or even if not)
  if (_initialIndex != null || _vowelIndex != null) {
    _commitSyllable();
  }
  _initialIndex = _fullInitialConsonants.indexOf(c);
  _vowelIndex = null;
  _finalIndex = null;
  _updateController();
}

void _pressVowel(String v) {
  if (_initialIndex == null) {
    // Optional: automatically start a dummy initial (like 'ㅇ') if vowel pressed first
    _initialIndex = 11; // 'ㅇ' index in _fullInitialConsonants
  }
  _vowelIndex = _fullVowels.indexOf(v);
  _finalIndex = null;
  _updateController();
}

void _pressFinal(String f) {
  if (_initialIndex != null && _vowelIndex != null) {
    _finalIndex = _fullFinalConsonants.indexOf(f);
    _commitSyllable();
  }
}

void _commitSyllable() {
  if (_initialIndex == null) return;

  int finalIndex = _finalIndex ?? 0;
  int vowelIndex = _vowelIndex ?? 0;

  final syllable = String.fromCharCode(
    0xAC00 + (_initialIndex! * 21 + vowelIndex) * 28 + finalIndex,
  );

  _currentInput += syllable;

  // Reset buffer for next syllable
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

  _controller.text = preview;
  _controller.selection = TextSelection.fromPosition(
    TextPosition(offset: _controller.text.length),
  );
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
        const Text('Endkonsonanten', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 4,
          children: finalConsonants.map((f) => ElevatedButton(
            onPressed: () => _pressFinal(f),
            child: Text(f, style: const TextStyle(fontSize: 20)),
          )).toList(),
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _backspace,
          icon: const Icon(Icons.backspace),
          label: const Text('Löschen'),
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
          value: 4 / 5,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 4,
        ),

          const SizedBox(height: 30),

          // Aufbau
          const Text(
            'J und CH',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Es fehlen uns nur noch zwei Einzelkonsonanten! \n\nㅈ (j) wird ausgesprochen wie in "DSCHungel". \n\nㅊ (ch) ist die härtere Version von den Beiden, wird ausgesprochen wie in "TSCHernobyl".',
            style: TextStyle(fontSize: 16),
          ),



          const Divider(height: 28),

          // Konsonanten
          const Text(
            'Neue Konsonanten',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          _JamoGrid(
            items: [
              _Jamo('ㅈ', 'j', 'wie in "Dschungel"'),
              _Jamo('ㅊ', 'ch', 'wie in "Tschernobyl"'),
            ],
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
      _buildAudioCard(context, '앞 차기', 'audio/ap_chagi.mp3'),
      _buildAudioCard(context, '얼굴 지르기', 'audio/eolgul_jireugi.mp3'),
      _buildAudioCard(context, '준비', 'audio/junbi.mp3'),
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
            style: const TextStyle(fontSize: 28),
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
                      MaterialPageRoute(builder: (_) => HangulLevel22()), // or MainPage()
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
                      MaterialPageRoute(builder: (_) => HangulLevel24()), // or MainPage()
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
