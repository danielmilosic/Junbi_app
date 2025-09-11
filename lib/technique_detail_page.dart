import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:junbi/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // New field for resolved image path
  String? _currentImagePath;

  @override
  void initState() {
    super.initState();

    // Timer for switching images every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _showStartImage = !_showStartImage;
        _updateImagePath(); // update image path when toggling
      });
    });

    // Audio player setup
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });

    // Initial image path
    _updateImagePath();
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
        final audioPath = 'audio/${widget.techniqueKey}.mp3';
        await _audioPlayer.play(AssetSource(audioPath));
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Audio not available: $e')),
        );
      }
    } else {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  // New method: tries start image first, fallback if missing
  Future<void> _updateImagePath() async {
    final startImage = 'assets/images/${widget.techniqueKey}_start.png';
    final fallbackImage = 'assets/images/${widget.techniqueKey}.png';

    if (_showStartImage) {
      try {
        await rootBundle.load(startImage);
        _currentImagePath = startImage;
      } catch (_) {
        _currentImagePath = fallbackImage;
      }
    } else {
      _currentImagePath = fallbackImage;
    }

    if (mounted) setState(() {}); // trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    final info = AppStrings.techniqueInformation[widget.techniqueKey];

    final latinName = info?[0] ?? widget.techniqueKey;
    final hangulName = info?[1] ?? "";
    final germanName = info?[2] ?? "";
    final explanation = info?[4] ?? "No explanation available.";

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
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
                    style: const TextStyle(fontSize: 24),
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

                // Technique image (switching)
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: _currentImagePath == null
                        ? const SizedBox() // placeholder while loading
                        : Image.asset(
                            _currentImagePath!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported,
                                  size: 100);
                            },
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                // Explanation
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: SizedBox(
                    width: 315,
                    child: Text(
                      explanation,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Audio play/pause button
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: ElevatedButton.icon(
                    onPressed: _toggleAudio,
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(_isPlaying ? 'Anhören' : 'Anhören'),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
