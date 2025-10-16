import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// HangulPage
/// Eine übersichtliche, interaktive Seite, die auf Deutsch erklärt,
/// wie das koreanische Schriftsystem (Hangul) aufgebaut ist.


class DojangEtiquettePage extends StatelessWidget {
  const DojangEtiquettePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: _EtiquetteContent(),
        ),
      ),
    );
  }
}

class _EtiquetteContent extends StatefulWidget {
  const _EtiquetteContent({Key? key}) : super(key: key);

  @override
  State<_EtiquetteContent> createState() => _EtiquetteContentState();
}

class _EtiquetteContentState extends State<_EtiquetteContent> {
    
  Widget _buildRule(BuildContext context, String text, String imageFile) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Image.asset(
                imageFile,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 20,
                    color: Colors.white,
                  );
                },
              ),
            ],
          ),
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
            'Dojang Etiquette',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Im Dojang gibt es ein paar Verhaltensregeln um Sicherheit und Respekt aufrecht zu erhalten',
            style: TextStyle(fontSize: 16),
          ),

          const Divider(height: 60),

          _buildRule(context, 'Immer Respektvoller Umgang miteinander.', 'assets/images/gyeongnye.png'),

          const Divider(height: 60),

          _buildRule(context, 'Immer genügend Abstand halten.', 'assets/images/il_bo_daeryeon.png'),

          const Divider(height: 60),

          _buildRule(context, 'Hände und Füße waschen vor dem Training.', 'assets/images/hand.png'),

          const Divider(height: 60),

          _buildRule(context, 'Beim Betreten und Verlassen des Dojang verbeugen.', 'assets/images/verbeugen.png'),

          const Divider(height: 60),

          _buildRule(context, 'Während dem Training: Keine Armbanduhren, Schmuck, Ohrringe, Ketten, Piercings.', 'assets/images/uhr.png'),

          const Divider(height: 60),

          _buildRule(context, 'Vor und nach jeder Übung verbeugen.', 'assets/images/gyeongnye.png'),

          const Divider(height: 60),

          _buildRule(context, 'Zuschauen immer im Schneidersitz mit aufrechtem Rücken. Nicht anlehnen.', 'assets/images/schneidersitz.png'),

          const Divider(height: 60),

          _buildRule(context, 'Die Höhergraduierte Person beginn immer mit der Übung.', 'assets/images/il_bo_daeryeon_start.png'),

          const Divider(height: 60),

          _buildRule(context, 'Niedergraduierte kehren den Dojang nach dem Training auf.', 'assets/images/besen.png'),

          const Divider(height: 60),

          _buildRule(context, 'Während dem Training wird nicht getrunken.', 'assets/images/wasser.png'),

          const Divider(height: 60),

          _buildRule(context, 'Wenn man das Training verlassen will, muss man sich abmelden.', 'assets/images/melden.png'),

          const Divider(height: 60),

          _buildRule(context, 'Bei Übungen zu zweit, immer nach Konsens fragen.', 'assets/images/konsens.png'),

          const Divider(height: 60),

          _buildRule(context, 'Nicht krank zum Training kommen.', 'assets/images/krank.png'),

          const Divider(height: 60),

          _buildRule(context, 'Wenn man den Dobok richtet, dreht man sich weg.', 'assets/images/dobok.png'),




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
