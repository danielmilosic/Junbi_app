import 'package:flutter/material.dart';
import 'package:junbi/curriculum_detail_page.dart';
import 'package:junbi/dojang_etiquette_page.dart';

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key});

  @override
  Widget build(BuildContext context) {

    final belts = ['white','yellow', 'green', 'blue', 'red', 'black'];
    final beltRanks = ['Dojang Etiquette', '8. Geup', '6. Geup', '4. Geup', '2. Geup', '1. Dan'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:50.0, left:20, right:20, bottom:20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Curriculum',
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
                      if (belt == 'white'){
                     // Navigate to DojangEtiquettePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DojangEtiquettePage(),
                          ),
                        );

                      }else{
                        // Navigate to TechniqueDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CurriculumDetailPage(beltRank: belt, belt:beltRank),
                          ),
                        );
                      }
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
