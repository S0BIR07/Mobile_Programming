import 'package:flutter/material.dart';

class Task1Screen extends StatefulWidget{
  const Task1Screen({super.key});

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  bool _isDarkMode=false;
  bool _agreedToTerms=false;

  @override
Widget build(BuildContext context) {
  final Color textColor = _isDarkMode ? Colors.white : Colors.black;
  final Color subtitleColor = _isDarkMode ? Colors.grey[400]! : Colors.black54;

  return Scaffold(
    backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
    appBar: AppBar(
      backgroundColor: _isDarkMode ? Colors.black : Colors.blue,
      foregroundColor: Colors.white,
      title: const Text('Task 1'),
    ),
    body: ListView(
      children: [
        SwitchListTile(
          title: Text(
            'Dark Mode',
            style: TextStyle(color: textColor),
          ),
          subtitle: Text(
            'Enable dark theme across app',
            style: TextStyle(color: subtitleColor),
          ),
          value: _isDarkMode,
          onChanged: (bool value) {
            setState(() {
              _isDarkMode = value;
            });
          },
        ),
        Divider(color: _isDarkMode ? Colors.grey[700] : Colors.grey[300]),
        CheckboxListTile(
          title: Text(
            'Agree to Terms',
            style: TextStyle(color: textColor),
          ),
          subtitle: Text(
            'You must accept terms to proceed',
            style: TextStyle(color: subtitleColor),
          ),
          value: _agreedToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreedToTerms = value ?? false;
            });
          },
        ),
        const SizedBox(height: 20),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: _agreedToTerms
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to next page...')),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isDarkMode ? Colors.blueAccent : Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        ),
      ],
    ),
  );
}
}