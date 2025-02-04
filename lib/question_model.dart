// question_model.dart

class Option {
  final String text;
  final bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect,
  });
}

class Question {
  final String questionText;
  final List<Option> options;
  final int timeLimit;
  final String explanation;
  final String hint;
  final String subject; // Added subject
  final String difficulty; // Add difficulty as a property

  Question({
    required this.questionText,
    required this.options,
    required this.timeLimit,
    required this.explanation,
    required this.hint,
    required this.subject,
    required this.difficulty, // Include difficulty in the constructor
  });
}
