import 'package:flutter/material.dart';

class Task6Screen extends StatefulWidget {
  const Task6Screen({super.key});

  @override
  State<Task6Screen> createState() => _Task6ScreenState();
}

class _Task6ScreenState extends State<Task6Screen> {
  double _volume = 50.0;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 6: Sliders & Pickers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Volume Level: ${_volume.round()}%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${_volume.round()}%',
              onChanged: (double value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
            const Divider(height: 50),
            Text(
              _selectedDate == null
                  ? 'No Date Selected'
                  : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Pick a Date'),
            ),
          ],
        ),
      ),
    );
  }
}