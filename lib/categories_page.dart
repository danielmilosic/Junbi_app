import 'package:flutter/material.dart';
import 'strings.dart'; // import your constants
import 'package:junbi/technique_detail_page.dart';

class CategoriesPage extends StatelessWidget {
  final String categoryKey;

  const CategoriesPage({super.key, required this.categoryKey});


  @override
  Widget build(BuildContext context) {
    // Collect all technique arrays and avoid duplicates

    final listOfKeys = <String>[];
    final listOfTechniques = <String>[];

    // Loop through all technique lists in strings.dart
    AppStrings.techniqueInformation.forEach((arrayName, info) {
      final category = info[3] ?? ""; // category
      final techniqueName = info[0] ?? ""; // Romanized name

      if (category == categoryKey) {
        listOfTechniques.add(techniqueName);
        listOfKeys.add(arrayName);
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:50.0, left:20, right:20, bottom:20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              categoryKey,
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
                itemCount: listOfTechniques.length,
                itemBuilder: (context, index) {
                  final techniqueName = listOfTechniques[index];
                  final imageName = listOfKeys[index];
                  final imagePath = 'assets/images/$imageName.png';

                  return Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Navigate to CategoriesParge
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TechniqueDetailPage(techniqueKey: imageName),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Hero(tag:imagePath,
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
                            techniqueName,
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
