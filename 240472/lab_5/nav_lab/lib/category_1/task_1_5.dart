import 'package:flutter/material.dart';

class BackOrExitButton extends StatelessWidget {
  const BackOrExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return ElevatedButton(
      onPressed: canPop ? () => Navigator.pop(context) : null,
      child: Text(canPop ? 'Back' : 'Nothing to go back to'),
    );
  }
}

class Task1_5RootScreen extends StatelessWidget {
  const Task1_5RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1.5: Root Screen'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Root Screen (Bottom of Stack)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const BackOrExitButton(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PushedScreen()),
                );
              },
              child: const Text('Push PushedScreen'),
            ),
          ],
        ),
      ),
    );
  }
}

class PushedScreen extends StatelessWidget {
  const PushedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pushed Screen'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pushed Screen (Top of Stack)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const BackOrExitButton(),
          ],
        ),
      ),
    );
  }
}