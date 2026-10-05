import 'package:flutter/material.dart';

class Task8Screen extends StatelessWidget {
  const Task8Screen({super.key});

  final List<String> imageUrls = const [
    'https://picsum.photos/id/10/400/400',
    'https://picsum.photos/id/20/400/400',
    'https://picsum.photos/id/30/400/400',
    'https://picsum.photos/id/40/400/400',
    'https://picsum.photos/id/50/400/400',
    'https://picsum.photos/id/60/400/400',
  ];

  void _showPreview(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 8: Grid Displays'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        children: imageUrls.map((url) {
          return InkWell(
            onTap: () => _showPreview(context, url),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(url, fit: BoxFit.cover),
            ),
          );
        }).toList(),
      ),
    );
  }
}