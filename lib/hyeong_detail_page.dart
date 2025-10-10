import 'package:flutter/material.dart';
import 'package:junbi/strings.dart';
import 'package:junbi/technique_detail_page.dart'; // <-- import your detail page
import 'package:audioplayers/audioplayers.dart';

class HyeongDetailPage extends StatelessWidget {
  final String title;
  final String hangulTitle;
  final String hanjaTitle;
  final int movements;
  final String description;
  final String imagePath; // could be asset or network
  final List<String> techniques;

  const HyeongDetailPage({
    super.key,
    required this.title,
    required this.hangulTitle,
    required this.hanjaTitle,
    required this.movements,
    required this.description,
    required this.imagePath,
    required this.techniques,
  });

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer(); // create a player
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Fixed header
          Padding(
            padding: const EdgeInsets.only(top:50.0, left:20, right:20, bottom:20),
            child: Column(
              children: [
                Row(
                  children: [
                    // Left (Hangul)
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          hangulTitle,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      
                    ),
                    
                    // Center (Title)
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.volume_up, size: 20, color: Colors.white,),
                      onPressed: () async {
                        try {
                          final audioPath = 'audio/${title.toLowerCase().replaceAll(' ', '_')}.mp3';
                          await audioPlayer.play(AssetSource(audioPath));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Audio not available')),
                          );
                        }
                      },
                    ),

                    // Right (Hanja)
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          hanjaTitle,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 12),
                Text(
                  "Bewegungen: $movements",
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top:50.0, left:20, right:20, bottom:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 12),

                    // Diagram image
                    Center(
                      child: Image.asset(
                        imagePath,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Techniques list
                    const Text(
                      "Techniken:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: techniques.length,
                      itemBuilder: (context, index) {
                        final techniqueKey = techniques[index];
                        final info =
                            AppStrings.techniqueInformation[techniqueKey];

                        final displayName = info?[0] ?? techniqueKey; // Romanized
                        final hangulName = info?[1] ?? ""; // Hangul
                        final techniqueImagePath =
                            'assets/images/$techniqueKey.png';

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TechniqueDetailPage(techniqueKey: techniqueKey),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.black,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Names (left side)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          displayName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (hangulName.isNotEmpty)
                                          Text(
                                            hangulName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Image (right side)
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Hero(tag:techniqueImagePath,
                                      child: Image.asset(
                                        techniqueImagePath,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.image_not_supported,
                                            size: 40,
                                            color: Colors.white,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
                                                        Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
        ],
      ),
    );
  }
}
