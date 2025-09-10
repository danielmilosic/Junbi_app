import 'package:flutter/material.dart';

class HyeongPage extends StatelessWidget {
  const HyeongPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of items for the RecyclerView replacement
    final List<String> hyeongItems = [
      'Hyeong 1',
      'Hyeong 2',
      'Hyeong 3',
      'Hyeong 4',
      'Hyeong 5',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyeong (형)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Title
            const Text(
              'Hyeong (형)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Explanation text
            const SizedBox(
              width: 289,
              child: Text(
                'Hier kommt die Erklärung für Hyeong (z.B. aus strings.xml)',
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // List replacing RecyclerView
            Expanded(
              child: ListView.builder(
                itemCount: hyeongItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        hyeongItems[index],
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        // Add navigation or detail action here
                      },
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
