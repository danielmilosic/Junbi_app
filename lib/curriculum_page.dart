import 'package:flutter/material.dart';
import 'package:junbi/curriculum_detail_page.dart';
import 'strings.dart'; // import your constants

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Collect all technique arrays and avoid duplicates
    final Map<String, String> categoryMap = {}; // category -> imageName
    final usedCategories = <String>{};
    final belts = ['yellow', 'green', 'blue', 'red', 'black'];
    final beltRanks = ['8. Geup', '6. Geup', '4. Geup', '2. Geup', '1. Dan'];
    // Loop through all technique lists in strings.dart
    AppStrings.techniqueInformation.forEach((arrayName, CurriculumPage) {
      final info = AppStrings.techniqueInformation[arrayName];
      final category = info?[3] ?? ""; // or map differently if needed

      if (!usedCategories.contains(category)) {
        categoryMap[category] = arrayName; // imageName same as key
        usedCategories.add(category);
      }
    },
  );

    final categoryList = categoryMap.entries.toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:50.0, left:20, right:20, bottom:20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Kurrikulum',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Grid of technique categories
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: belts.length,
                itemBuilder: (context, index) {
                  final categoryName = categoryList[index].key;
                  final imageName = categoryList[index].value;
                  final belt = belts[index];
                  final beltRank = beltRanks[index];
                  final imagePath = 'assets/images/$belt'+'_belt.png';

                  return Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Navigate to TechniqueDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CurriculumDetailPage(beltRank: belt, belt:beltRank),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Hero(tag: imagePath,
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported, size: 40),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            beltRank,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
