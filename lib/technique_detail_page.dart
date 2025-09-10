import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:junbi/strings.dart';

class TechniqueDetailPage extends StatefulWidget {
  final String techniqueKey;

  const TechniqueDetailPage({super.key, required this.techniqueKey});

  @override
  State<TechniqueDetailPage> createState() => _TechniqueDetailPageState();
}

class _TechniqueDetailPageState extends State<TechniqueDetailPage> {
  late Timer _timer;
  bool _showStartImage = false;

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    // Timer for switching images every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _showStartImage = !_showStartImage;
      });
    });

    // Audio player setup
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleAudio() async {
    if (!_isPlaying) {
      try {
        await _audioPlayer.play(AssetSource('assets/audio/${widget.techniqueKey}.mp3'));
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audio not available:')),
        );
      }
    } else {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = AppStrings.techniqueInformation[widget.techniqueKey];

    final latinName = info?[0] ?? widget.techniqueKey;
    final hangulName = info?[1] ?? "";
    final germanName = info?[2] ?? "";
    final explanation = info?[4] ?? "No explanation available.";

    final imagePath = _showStartImage
        ? 'assets/images/${widget.techniqueKey}_start.png'
        : 'assets/images/${widget.techniqueKey}.png';

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Latin name
                Text(
                  latinName,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Hangul name
                if (hangulName.isNotEmpty)
                  Text(
                    hangulName,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 12),

                // German name
                SizedBox(
                  width: 315,
                  child: Text(
                    germanName,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // Audio play/pause button
                ElevatedButton.icon(
                  onPressed: _toggleAudio,
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  label: Text(_isPlaying ? 'Anhören' : 'Anhören'),
                ),

                const SizedBox(height: 50),

                // Technique image (switching)
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 100);
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Explanation
                SizedBox(
                  width: 315,
                  child: Text(
                    explanation,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
