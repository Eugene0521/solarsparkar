import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz.dart';

class QuizQuestionPage extends StatefulWidget {
  final Quiz quiz;
  final String userId; // Pass user ID

  const QuizQuestionPage({super.key, required this.quiz, required this.userId});

  @override
  _QuizQuestionPageState createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  int _score = 0;
  bool _showFeedback = false;

  Future<void> updateHighestScore() async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final quizzes = data?['quizzes'] as Map<String, dynamic>?;
      final currentQuiz = quizzes?[widget.quiz.title];
      final highestScore = currentQuiz?['highestScore'] ?? 0;

      if (_score > highestScore) {
        await userDoc.set({
          'quizzes': {
            widget.quiz.title: {
              'highestScore': _score,
              'totalQuestions': widget.quiz.questions.length,
            },
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _handleAnswerSelection(int index) {
    setState(() {
      _selectedAnswerIndex = index;
      _showFeedback = true;

      if (index == widget.quiz.questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _moveToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _showFeedback = false;
      } else {
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
  updateHighestScore();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Quiz Completed!'),
      content: Text('Your score: $_score/${widget.quiz.questions.length}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context, true); // Pass 'true' to indicate quiz completion
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        backgroundColor: const Color(0xFF2B223E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${_currentQuestionIndex + 1}. ${question.question}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(question.options.length, (index) {
              final isSelected = index == _selectedAnswerIndex;
              final isCorrect = index == question.correctAnswerIndex;

              Color getOptionColor() {
                if (_showFeedback) {
                  if (isSelected) {
                    return isCorrect ? Colors.green : Colors.red;
                  } else if (isCorrect) {
                    return Colors.green;
                  }
                }
                return Colors.grey.shade300;
              }

              return GestureDetector(
                onTap: !_showFeedback ? () => _handleAnswerSelection(index) : null,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: getOptionColor(),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Text(
                    question.options[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: _showFeedback ? _moveToNextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC5B20),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                _currentQuestionIndex < widget.quiz.questions.length - 1
                    ? 'Next'
                    : 'Finish',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
