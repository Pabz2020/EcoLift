import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: WelcomeWidget(
          onNextPressed: null,
        ),
      ),
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  final VoidCallback? onNextPressed;

  const WelcomeWidget({super.key, this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Welcome to ECO LIFT',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Waste to Wonders',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onNextPressed ??
              () {
                Navigator.pushNamed(context, '/about_app');
              },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }
}
