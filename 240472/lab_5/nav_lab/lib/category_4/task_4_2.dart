import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4.2: Send a Number'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [1, 2, 3].map((number) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/square',
                  arguments: number,
                );
              },
              child: Text(
                '$number',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SquareScreen extends StatelessWidget {
  const SquareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int number = ModalRoute.of(context)!.settings.arguments as int;
    final int square = number * number;

    return Scaffold(
      appBar: AppBar(
        title: Text('Square of $number'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Number: $number',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              'Square: $square',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}