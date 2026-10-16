import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _movieTitle = 'Inception';
  int? _rating;

  Future<void> _openRatingScreen() async {
    final int? result = await Navigator.pushNamed<int>(
      context,
      '/rate',
      arguments: _movieTitle,
    );

    if (result != null) {
      setState(() {
        _rating = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4.5: Movie Rating'),
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Movie: $_movieTitle',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _rating == null ? 'Rating: Not rated yet' : 'Rating: $_rating/5',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.star),
              label: const Text('Rate Movie'),
              onPressed: _openRatingScreen,
            ),
          ],
        ),
      ),
    );
  }
}

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String movieTitle = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rate "$movieTitle"'),
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a Rating:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final int starValue = index + 1;
                return IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.star, color: Colors.amber),
                  onPressed: () {
                    // Return rating integer back to Home
                    Navigator.pop(context, starValue);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}