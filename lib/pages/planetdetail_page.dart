// planetdetail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'arinteraction_page.dart';
import '../models/planet.dart'; // Import the Planet class

class PlanetDetailPage extends StatefulWidget {
  final Planet planet;

  const PlanetDetailPage({super.key, required this.planet});

  @override
  State<PlanetDetailPage> createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends State<PlanetDetailPage> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _startNarration(widget.planet.description); // Start narration on page load
  }

  Future<void> _startNarration(String text) async {
    if (!_isMuted) {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.5); // Adjust for a natural tone
      await _flutterTts.speak(text);
    }
  }

  Future<void> _stopNarration() async {
    await _flutterTts.stop();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_isMuted) {
        _stopNarration();
      } else {
        _startNarration(widget.planet.description);
      }
    });
  }

  @override
  void dispose() {
    _stopNarration();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.planet.name} Details',
          style: const TextStyle(color: Colors.white), // White text for AppBar title
        ),
        backgroundColor: const Color(0xFF2B223E), // AppBar background color
        iconTheme: const IconThemeData(color: Colors.white), // White back icon
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: Image.asset(widget.planet.imagePath), // Display planet image
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    widget.planet.description, // Display planet description
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Button at the bottom
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to AR view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ARInteractionPage(planet: widget.planet),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC5B20), // Match the button color
                padding: const EdgeInsets.symmetric(vertical: 16.0), // Button height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Rounded corners
                ),
              ),
              child: const Text(
                'Explore',
                style: TextStyle(fontSize: 18, color: Colors.white), // Button text style
              ),
            ),
          ),
          // Mute/Unmute button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(
                _isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: _toggleMute,
            ),
          ),
        ],
      ),
    );
  }
}
