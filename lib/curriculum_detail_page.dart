import 'package:flutter/material.dart';
import 'package:junbi/strings.dart';
import 'package:junbi/technique_detail_page.dart';
import 'package:junbi/hyeong_detail_page.dart';

class CurriculumDetailPage extends StatelessWidget {
  final String beltRank;
  final String belt;

  const CurriculumDetailPage({
    super.key,
    required this.beltRank,
    required this.belt,
  });

  // Helper to get techniques and hyeongs based on belt
  Map<String, dynamic> _getCurriculumData() {
    final allEntries = AppStrings.techniqueInformation.entries
        .map((entry) => MapEntry(entry.key, entry.value[0]))
        .toList();

    final hyeongItems = List<String>.from(AppStrings.hyeong_data);

      final beltRankDependentTechniques = switch (beltRank) {
        'yellow' => allEntries.take(19).toList().toList(),
        'green' => allEntries.take(36).toList().reversed.toList(),
        'blue' => allEntries.take(52).toList().reversed.toList(),
        'red' => allEntries.take(65).toList().reversed.toList(),
        'black' => allEntries.take(79).toList().reversed.toList(),
        _ => allEntries.reversed.toList(),
      };

      final oldTechniques = switch (beltRank) {
      'yellow' => allEntries.take(0).toList(),
      'green' => allEntries.take(19).toList(),
      'blue' => allEntries.take(36).toList(),
      'red' => allEntries.take(52).toList(),
      'black' => allEntries.take(65).toList(),
      _ => allEntries,
    };

    final beltRankDependentHyeongs = switch (beltRank) {
      'yellow' => hyeongItems.take(2).toList(),
      'green' => hyeongItems.take(4).toList(),
      'blue' => hyeongItems.take(6).toList(),
      'red' => hyeongItems.take(8).toList(),
      'black' => hyeongItems.toList(),
      _ => hyeongItems,
    };

    final oldHyeongs = switch (beltRank) {
      'yellow' => hyeongItems.take(0).toList(),
      'green' => hyeongItems.take(2).toList(),
      'blue' => hyeongItems.take(4).toList(),
      'red' => hyeongItems.take(6).toList(),
      'black' => hyeongItems.toList(),
      _ => hyeongItems,
    };

    final beltImagePath = 'assets/images/${beltRank}_belt.png';

    return {
      'techniques': beltRankDependentTechniques,
      'hyeongs': beltRankDependentHyeongs,
      'oldTechniques': oldTechniques,
      'oldHyeongs': oldHyeongs,
      'beltImage': beltImagePath,
    };
  }

  @override
  Widget build(BuildContext context) {
    final data = _getCurriculumData();
    final beltRankDependentTechniques = data['techniques'] as List<MapEntry<String, String>>;
    final beltRankDependentHyeongs = data['hyeongs'] as List<String>;
    final beltImagePath = data['beltImage'] as String;
    final oldHyeongs = data['oldHyeongs'] as List<String>;
    final oldTechniques = data['oldTechniques'] as List<MapEntry<String, String>>;


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20, bottom: 20),
            child: Center(
              child: Text(
                belt.toUpperCase(),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const Divider(height: 1),

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Belt image
                    Center(
                      child: Hero(tag: beltImagePath,
                        child: Image.asset(
                          beltImagePath,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported, size: 100);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Hyeongs section
                    const Text(
                      "Hyeongs:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: beltRankDependentHyeongs.length,
                      itemBuilder: (context, index) {
                        final parts = beltRankDependentHyeongs[index].split('|');
                        final title = parts[0].trim(); // first part before |
                        final hangul = parts[1].trim();
                        final hanja = parts[2].trim();
                        final shortDescription = parts[3].trim();
                        final description = parts[6].trim();
                        final movements = int.parse(parts[4].trim());
                        final hyeongNumber = index+1;
                        final techniques = AppStrings.HyeongTechniqueLists["techniqueNames_$hyeongNumber"] ?? [];
                        final hyeongKey = beltRankDependentHyeongs[index];
                        final info = AppStrings.techniqueInformation[hyeongKey];
                        final hangulName = info?[1] ?? '';
                        final hyeongImagePath = 'assets/images/hyeong${index+1}_diagram.png';
                        final Cardcolor = oldHyeongs.contains(hyeongKey) ? const Color.fromARGB(255, 31, 31, 31) : Colors.black;

                        return InkWell(
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
                                      imagePath: hyeongImagePath,
                                      techniques: techniques,
                            ),
                          ),
                        );
                          },
                          child: Card(
                            color: Cardcolor,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title+'\n'+hangul,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (hangulName.isNotEmpty)
                                          Text(
                                            hangulName,
                                            style: const TextStyle(fontSize: 14, color: Colors.white),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Hero(
                                      tag: hyeongImagePath,
                                      child: Image.asset(
                                        hyeongImagePath,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.image_not_supported,
                                              size: 40, color: Colors.white);
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
                    ),

                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 36),

                    // Techniques section
                    const Text(
                      "Begriffe:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: beltRankDependentTechniques.length,
                      itemBuilder: (context, index) {
                        final techniqueKey = beltRankDependentTechniques[index].key;
                        final info = AppStrings.techniqueInformation[techniqueKey];
                        final displayName = info?[0] ?? techniqueKey;
                        final hangulName = info?[1] ?? '';
                        final techniqueImagePath = 'assets/images/$techniqueKey.png';
                        final Cardcolor = oldTechniques.contains(beltRankDependentTechniques[index]) ? const Color.fromARGB(255, 31, 31, 31) : Colors.black;
                        

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TechniqueDetailPage(techniqueKey: techniqueKey),
                              ),
                            );
                          },
                          child: Card(
                            color: Cardcolor,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Hero(
                                      tag: techniqueImagePath,
                                      child: Image.asset(
                                        techniqueImagePath,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.image_not_supported,
                                              size: 40, color: Colors.white);
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
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Back button
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
