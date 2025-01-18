import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz.dart';
import 'quiz_question_page.dart';

class QuizDescriptionPage extends StatefulWidget {
  final Quiz quiz;
  final String userId; // Pass user ID

  const QuizDescriptionPage({super.key, required this.quiz, required this.userId});

  @override
  _QuizDescriptionPageState createState() => _QuizDescriptionPageState();
}

class _QuizDescriptionPageState extends State<QuizDescriptionPage> {
  Future<Map<String, dynamic>?> fetchQuizData(String userId, String quizId) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final quizzes = data?['quizzes'] as Map<String, dynamic>?;

      if (quizzes != null && quizzes.containsKey(quizId)) {
        return quizzes[quizId];
      }
    }
    return null; // Return null if no data exists
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.quiz.title,
          style: const TextStyle(color: Colors.white), // AppBar title in white
        ),
        backgroundColor: const Color(0xFF2B223E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchQuizData(widget.userId, widget.quiz.title), // Fetch quiz data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to load data.',
                style: TextStyle(color: Colors.white), // Error message in white
              ),
            );
          } else {
            final quizData = snapshot.data;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.quiz.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Title in white
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.quiz.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Description in white
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (quizData != null)
                    Text(
                      'Highest Score: ${quizData['highestScore']}/${quizData['totalQuestions']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Highlight highest score in green
                      ),
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Navigate to QuizQuestionPage and wait for a result
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizQuestionPage(
                              quiz: widget.quiz,
                              userId: widget.userId,
                            ),
                          ),
                        );
                        if (result == true) {
                          setState(() {}); // Refresh the page if the quiz was completed
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC5B20),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(fontSize: 18, color: Colors.white), // Button text in white
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
