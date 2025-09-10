import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Fixed header
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hangulTitle,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      hanjaTitle,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Movements: $movements",
                  style: const TextStyle(fontSize: 16),
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
                padding: const EdgeInsets.all(12.0),
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
                    Image.asset(
                      imagePath,
                      height: 160,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(height: 12),

                    // Techniques list
                    const Text(
                      "Techniques:",
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
                        return ListTile(
                          leading: const Icon(Icons.fitness_center),
                          title: Text(techniques[index]),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
