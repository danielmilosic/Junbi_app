import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:junbi/strings.dart';
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
  bool _hasStartImage = false;

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  late String _fallbackImage;
  late String _startImage;

  @override
  void initState() {
    super.initState();

    _fallbackImage = 'assets/images/${widget.techniqueKey}.png';
    _startImage = 'assets/images/${widget.techniqueKey}_start.png';

    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) setState(() => _isPlaying = false);
    });

    _precacheImages(); // ✅ Precache once before toggling

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _showStartImage = !_showStartImage;
        });
      }
    });
  }

  Future<void> _precacheImages() async {
    try {
      await rootBundle.load(_startImage);
      _hasStartImage = true;
      // ✅ Precache both images in memory before first frame
      await Future.wait([
        precacheImage(AssetImage(_fallbackImage), context),
        precacheImage(AssetImage(_startImage), context),
      ]);
    } catch (_) {
      _hasStartImage = false;
      await precacheImage(AssetImage(_fallbackImage), context);
    }
    if (mounted) setState(() {}); // initial draw
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
        if (mounted) setState(() => _isPlaying = true);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Audio not available: $e')),
          );
        }
      }
    } else {
      await _audioPlayer.stop();
      if (mounted) setState(() => _isPlaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = AppStrings.techniqueInformation[widget.techniqueKey];
    final latinName = info?[0] ?? widget.techniqueKey;
    final hangulName = info?[1] ?? "";
    final germanName = info?[2] ?? "";
    final explanation = info?[4] ?? "No explanation available.";
    final synonym = (info != null && info.length > 5) ? info[5] : "";


    final imagePath = (_showStartImage && _hasStartImage)
        ? _startImage
        : _fallbackImage;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              Text(
                latinName,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              if (hangulName.isNotEmpty)
                Text(
                  hangulName,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 12),

              SizedBox(
                width: 315,
                child: Text(
                  germanName,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 50),

              // Technique image
              SizedBox(
                width: 200,
                height: 200,
                child: Hero(
                  tag: _fallbackImage,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 0), // optional fade
                    child: Image.asset(
                      imagePath,
                      key: ValueKey(imagePath),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 100),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: 315,
                child: Text(
                  explanation,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 10),

              if (synonym.isNotEmpty) ...[
                SizedBox(
                  width: 315,
                  child: Text(
                    'Synonyme: $synonym',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
              ],

              ElevatedButton.icon(
                onPressed: _toggleAudio,
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                label: const Text('Anhören'),
              ),

              const SizedBox(height: 50),

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
    );
  }
}
