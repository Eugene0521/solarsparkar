import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/topic.dart';

class TopicDetailPage extends StatelessWidget {
  final Topic topic;

  const TopicDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    String videoID = YoutubePlayer.convertUrlToId(topic.videoUrl) ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          topic.title,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoID,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          const SizedBox(height: 20),
          Text(
            topic.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            topic.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Fun Facts",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...topic.funFacts.map(
            (fact) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      fact,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            topic.image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
