import 'package:flutter/material.dart';

class Step1Screen extends StatelessWidget {
  const Step1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 1'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Step 2'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Step2Screen()),
            );
          },
        ),
      ),
    );
  }
}

class Step2Screen extends StatelessWidget {
  const Step2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 2'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Step 3'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Step3Screen()),
            );
          },
        ),
      ),
    );
  }
}

class Step3Screen extends StatelessWidget {
  const Step3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 3'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Step 4'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Step4Screen()),
            );
          },
        ),
      ),
    );
  }
}

class Step4Screen extends StatelessWidget {
  const Step4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 4'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: const Text('Finish (Return to Step 1)'),
        ),
      ),
    );
  }
}