import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 10;

  Future<void> _openEditor() async {
    final int? newCount = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => CounterEditorScreen(initialCounter: _counter),
      ),
    );

    if (newCount != null) {
      setState(() {
        _counter = newCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3.5: Edit Counter'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter Value:', style: TextStyle(fontSize: 20)),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Edit Counter'),
              onPressed: _openEditor,
            ),
          ],
        ),
      ),
    );
  }
}

class CounterEditorScreen extends StatefulWidget {
  final int initialCounter;

  const CounterEditorScreen({super.key, required this.initialCounter});

  @override
  State<CounterEditorScreen> createState() => _CounterEditorScreenState();
}

class _CounterEditorScreenState extends State<CounterEditorScreen> {
  late int _editedValue;

  @override
  void initState() {
    super.initState();
    _editedValue = widget.initialCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Counter'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_editedValue',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      _editedValue--;
                    });
                  },
                ),
                const SizedBox(width: 20),
                IconButton.filled(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _editedValue++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, _editedValue);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}