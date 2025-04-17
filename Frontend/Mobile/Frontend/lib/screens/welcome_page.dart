import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WelcomeWidget(
          onNextPressed: () {
            Navigator.pushNamed(context, '/about_app');
          },
        ),
      ),
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  final VoidCallback onNextPressed;

  const WelcomeWidget({super.key, required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Welcome to ECO LIFT', style: TextStyle(fontSize: 24)),
        const Text('Waste to Wonders'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onNextPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text('Next'),
        ),
      ],
    );
  }
}
