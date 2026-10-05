import 'package:flutter/material.dart';

class Task4Screen extends StatefulWidget {
  const Task4Screen({super.key});

  @override
  State<Task4Screen> createState() => _Task4ScreenState();
}

class _Task4ScreenState extends State<Task4Screen> {
  bool _isLoading = false;

  void _startOperation() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Operation completed successfully!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4: Indicators & Feedback'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _startOperation,
                child: const Text('Start 3-Second Process'),
              ),
      ),
    );
  }
}