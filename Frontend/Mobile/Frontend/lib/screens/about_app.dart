import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AboutAppWidget(
          onContinuePressed: () {
            Navigator.pushNamed(context, '/role_selection');
          },
        ),
      ),
    );
  }
}

class AboutAppWidget extends StatelessWidget {
  final VoidCallback onContinuePressed;

  const AboutAppWidget({super.key, required this.onContinuePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Turn your waste into worth.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Join us to recycle smarter and keep the environment cleaner!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onContinuePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}
