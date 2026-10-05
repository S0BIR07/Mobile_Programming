import 'package:flutter/material.dart';

class Task10Screen extends StatelessWidget {
  const Task10Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 10: Structural Containers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Exercise 10.1: Card container with Header, Subtitle, Leading Icon, and Trailing Button
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.article, size: 40, color: Colors.blue),
              title: const Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('This is a detailed subtitle inside a Card container.'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Exercise 10.2: FAQ Screen with ExpansionTiles
          const ExpansionTile(
            title: Text('What is Flutter?'),
            subtitle: Text('Click to expand'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Flutter is Google\'s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.'),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What is Dart?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Dart is a client-optimized language for fast apps on any platform, used by Flutter.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}