import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import 'quiz_description_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print('Current User ID: $userId');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: const Text(
          "Quizzes",
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                quiz.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                quiz.description.length > 50
                    ? '${quiz.description.substring(0, 50)}...' // Truncate the description
                    : quiz.description,
              ),
              onTap: () {
                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizDescriptionPage(quiz: quiz, userId: userId),
                    ),
                  );
                } else {
                  // Handle the case when user is not authenticated
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User not authenticated."),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
