import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int yellowCorrect = 0;
  int greenCorrect = 0;
  int blueCorrect = 0;
  int redCorrect = 0;
  int blackCorrect = 0;
  int totalAnswers = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final results = prefs.getStringList('results') ?? [];

    int y = 0, g = 0, b = 0, r = 0, bl = 0;
    int total = 0, correct = 0;

    for (var line in results) {
      // Example line:
      // Total:10,Correct:8,Belt:yellow_belt,Level:yellow
      final regex = RegExp(r'Total:(\d+),Correct:(\d+),Belt:(.+),Level:(.+)');
      final match = regex.firstMatch(line);

      if (match != null) {
        final totalVal = int.parse(match.group(1)!);
        final correctVal = int.parse(match.group(2)!);
        final beltLevel = match.group(4)!.toLowerCase();

        total += totalVal;
        correct += correctVal;

        switch (beltLevel) {
          case 'yellow':
            y += correctVal;
            break;
          case 'green':
            g += correctVal;
            break;
          case 'blue':
            b += correctVal;
            break;
          case 'red':
            r += correctVal;
            break;
          case 'black':
            bl += correctVal;
            break;
        }
      }
    }

    setState(() {
      yellowCorrect = y;
      greenCorrect = g;
      blueCorrect = b;
      redCorrect = r;
      blackCorrect = bl;
      totalAnswers = total;
      correctAnswers = correct;
      incorrectAnswers = total - correct;
      isLoading = false;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(  // ✅ Move Center here
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // ✅ centers vertically
                  crossAxisAlignment: CrossAxisAlignment.center, // ✅ centers horizontally
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Gesamt: $totalAnswers  |  Richtig: $correctAnswers  |  Falsch: $incorrectAnswers',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom:16),
                      child: const SizedBox(height: 20),
                    ),
                    _buildPieChart(),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(top:16.0, bottom:16),
                      child: _buildBarChart(),
                    ),

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
              ),
            ),
          ),
  );
}

  Widget _buildPieChart() {
    if (totalAnswers == 0) {
      return const Center(child: Text('Keine Daten vorhanden.'));
    }

    final correctPct = (correctAnswers / totalAnswers) * 100;
    final incorrectPct = 100 - correctPct;

    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 50,
          sections: [
            PieChartSectionData(
              value: correctPct,
              color: Colors.green,
              title: '${correctPct.toStringAsFixed(1)}%\nRichtig',
              radius: 100,
              titleStyle: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              value: incorrectPct,
              color: Colors.red,
              title: '${incorrectPct.toStringAsFixed(1)}%\nFalsch',
              radius: 100,
              titleStyle: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    if (totalAnswers == 0) {
      return const SizedBox.shrink();
    }

    final barValues = [
      yellowCorrect.toDouble(),
      greenCorrect.toDouble(),
      blueCorrect.toDouble(),
      redCorrect.toDouble(),
      blackCorrect.toDouble(),
    ];

    final labels = ['Gelb', 'Grün', 'Blau', 'Rot', 'Schwarz'];
    final colors = [
      Colors.yellow.shade700,
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.black54,
    ];

    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < labels.length) {
                    return Text(labels[index]);
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize:35,showTitles: true),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(barValues.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: barValues[index],
                  color: colors[index],
                  width: 28,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
