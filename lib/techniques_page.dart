import 'package:flutter/material.dart';

class TechniquesPage extends StatelessWidget {
  const TechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Example technique categories
    final List<String> techniqueCategories = [
      'Punches',
      'Kicks',
      'Blocks',
      'Stances',
      'Combinations',
      'Sparring',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Begriffe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Begriffe',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Grid of technique categories
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,          // 2 squares per row
                  mainAxisSpacing: 12,        // vertical spacing
                  crossAxisSpacing: 12,       // horizontal spacing
                  childAspectRatio: 1,        // make squares
                ),
                itemCount: techniqueCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to category detail
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          techniqueCategories[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
