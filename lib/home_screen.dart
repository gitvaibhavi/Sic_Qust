// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'quiz_screen.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final List<String> categories = [
    'Biology',
    'Physics',
    'Chemistry',
    'Astronomy',
    'Earth Science',
    'History',
    'Mathematics',
    'Geography',
    'Economics',
    'Philosophy',
    'Political Science',
  ];

  final List<IconData> categoryIcons = [
    Icons.biotech, // Biology
    Icons.science, // Physics
    Icons.emoji_objects, // Chemistry
    Icons.star, // Astronomy
    Icons.public, // Earth Science
    Icons.history, // History
    Icons.calculate, // Mathematics
    Icons.map, // Geography
    Icons.account_balance, // Economics
    Icons.book, // Philosophy
    Icons.gavel, // Political Science
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade400, Colors.blue.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '🧬 SciQuest 🧬',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select a Category to Begin',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return _buildAnimatedCategoryCard(
                        context,
                        categories[index],
                        categoryIcons[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCategoryCard(
      BuildContext context, String category, IconData icon) {
    return AnimatedCategoryCard(
      category: category,
      icon: icon,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(category: category),
          ),
        );
      },
    );
  }
}

class AnimatedCategoryCard extends StatefulWidget {
  final String category;
  final IconData icon;
  final VoidCallback onTap;

  const AnimatedCategoryCard({
    Key? key,
    required this.category,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedCategoryCardState createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.9; // Scale down when pressed
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // Scale back to normal
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0; // Scale back to normal if tap is canceled
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (details) {
        _onTapUp(details);
        widget.onTap();
      },
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        scale: _scale,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          elevation: 8,
          shadowColor: Colors.black45,
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 40,
                  color: Colors.teal.shade700,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.teal.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
