import 'package:flutter/material.dart';
import 'question_model.dart';
import 'question_data.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({super.key, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  late List<Question> questions;
  late int _timeLeft;
  bool _showExplanation = false;
  String _selectedOption = '';

  @override
  void initState() {
    super.initState();
    questions = getQuestionsForCategory(widget.category);
    _timeLeft = questions[_currentIndex].timeLimit;
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 0 && _currentIndex < questions.length) {
        setState(() {
          _timeLeft--;
        });
        _startTimer();
      }
    });
  }

  void _checkAnswer(Option option) {
    setState(() {
      if (option.isCorrect) {
        _score += 10;
        _selectedOption = option.text;
      } else {
        _selectedOption = option.text;
      }
      _showExplanation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Text(
            'You scored: $_score',
            style: const TextStyle(fontSize: 24, color: Colors.green),
          ),
        ),
      );
    }

    Question currentQuestion = questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.deepPurple,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Score: $_score',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (_currentIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion.subject,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentQuestion.questionText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Center(
                  child: CircularProgressIndicator(
                    value: _timeLeft / questions[_currentIndex].timeLimit,
                    strokeWidth: 8,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
                Center(
                  child: Text(
                    '$_timeLeft',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...currentQuestion.options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  _checkAnswer(option);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: _selectedOption == option.text
                      ? (option.isCorrect ? Colors.green : Colors.red)
                      : Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  option.text,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            }),
            const SizedBox(height: 20),
            if (_showExplanation)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentQuestion.explanation,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentIndex++;
                  if (_currentIndex < questions.length) {
                    _timeLeft = questions[_currentIndex].timeLimit;
                    _selectedOption = '';
                    _showExplanation = false;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Next Question'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Hint'),
                      content: Text(currentQuestion.hint),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Show Hint'),
            ),
          ],
        ),
      ),
    );
  }
}
