class Quiz {
  final String title;
  final String description;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.description,
    required this.questions,
  });
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}
