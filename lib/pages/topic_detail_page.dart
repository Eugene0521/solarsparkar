import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/topic.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic topic;

  const TopicDetailPage({super.key, required this.topic});

  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  late YoutubePlayerController _youtubeController;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeYoutubePlayer();
    _startNarration(widget.topic.description);
  }

  void _initializeYoutubePlayer() {
    String videoID = YoutubePlayer.convertUrlToId(widget.topic.videoUrl) ?? "";
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoID,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );
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
        _startNarration(widget.topic.description);
      }
    });
  }

  @override
  void dispose() {
    _stopNarration();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        onReady: () {
          _stopNarration(); // Stop narration when video player is ready
        },
        onEnded: (_) {
          _startNarration(widget.topic.description); // Resume narration after video ends
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.topic.title,
              style: const TextStyle(color: Colors.white), // Ensure AppBar title text is white
            ),
            backgroundColor: const Color(0xFF2B223E),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: _toggleMute,
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              player, // Use the player widget here
              const SizedBox(height: 20),
              Text(
                widget.topic.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Change title text to white
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.topic.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Change description text to white
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Fun Facts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Change "Fun Facts" heading to white
                ),
              ),
              const SizedBox(height: 10),
              ...widget.topic.funFacts.map(
                (fact) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "• ",
                        style: TextStyle(color: Colors.white), // Change bullet points to white
                      ),
                      Expanded(
                        child: Text(
                          fact,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white, // Change facts text to white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                widget.topic.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}
