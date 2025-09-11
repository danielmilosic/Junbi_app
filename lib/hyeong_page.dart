import 'package:flutter/material.dart';
import 'strings.dart'; // import your constants
import 'hyeong_detail_page.dart';

class HyeongPage extends StatelessWidget {
  const HyeongPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> hyeongItems = AppStrings.hyeong_data;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            const Text(
              'Hyeong (형)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const SizedBox(
              width: 289,
              child: Text(
                AppStrings.hyeong_explanation,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // Dynamic list of buttons
            Expanded(
              child: ListView.builder(
                itemCount: hyeongItems.length,
                itemBuilder: (context, index) {
                  final parts = hyeongItems[index].split('|');
                  final title = parts[0].trim(); // first part before |
                  final hangul = parts[1].trim();
                  final hanja = parts[2].trim();
                  final description = parts[3].trim();
                  final movements = int.parse(parts[4].trim());
                  final hyeongNumber = index+1;
                  final imagePath = "assets/images/hyeong${hyeongNumber}_diagram.png";
                  final techniques = AppStrings.HyeongTechniqueLists["techniqueNames_$hyeongNumber"] ?? [];

                  return Card(
                    color: Colors.black,          // card background
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        '[$hyeongNumber] $title',
                        style: const TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      subtitle: hangul.isNotEmpty
                          ? Text(hangul, style: const TextStyle(fontSize: 20,color: Colors.white))
                          : null,
                      onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HyeongDetailPage(
                                      title: title,
                                      hangulTitle: hangul,
                                      hanjaTitle: hanja,
                                      movements: movements,
                                      description: description,
                                      imagePath: imagePath,
                                      techniques: techniques,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
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
      ),
    );
  }
}
