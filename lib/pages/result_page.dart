import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultPage extends StatefulWidget {
  final int totalQuestions;
  final int score;
  final String quizTitle;

  const ResultPage({
    super.key,
    required this.totalQuestions,
    required this.score,
    required this.quizTitle,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _displayedScore = 0;

  @override
  void initState() {
    super.initState();
    _saveHighestScoreToFirestore();
    _animateScore();
  }

  void _animateScore() async {
    for (int i = 0; i <= widget.score; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _displayedScore = i;
      });
    }
  }

  Future<void> _saveHighestScoreToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final quizDoc = userDoc.collection('quizzes').doc(widget.quizTitle);

    final quizData = await quizDoc.get();

    if (!quizData.exists || widget.score > (quizData['highestScore'] ?? 0)) {
      await quizDoc.set({
        'highestScore': widget.score,
        'totalQuestions': widget.totalQuestions,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: const Color(0xFF2B223E),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$_displayedScore / ${widget.totalQuestions}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC5B20),
              ),
              child: const Text('Back to Quizzes'),
            ),
          ],
        ),
      ),
    );
  }
}
