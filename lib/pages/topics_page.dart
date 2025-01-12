import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../data/topics_data.dart';
import 'topic_detail_page.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Topics",
          ),
          automaticallyImplyLeading: false, // Remove the back button from the AppBar
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final Topic topic = topics[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Image.asset(
                  topic.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  topic.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(topic.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicDetailPage(topic: topic),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
