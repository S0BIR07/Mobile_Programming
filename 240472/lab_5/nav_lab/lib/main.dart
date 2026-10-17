import 'package:flutter/material.dart';

import 'package:nav_lab/category_1/task_1_1.dart' as cat1_task1;
/*import 'package:nav_lab/category_1/task_1_2.dart' as cat1_task2;
import 'package:nav_lab/category_1/task_1_3.dart' as cat1_task3;
import 'package:nav_lab/category_1/task_1_4.dart' as cat1_task4;
import 'package:nav_lab/category_1/task_1_5.dart' as cat1_task5;

import 'package:nav_lab/category_2/task_2_1.dart' as cat2_task1;
import 'package:nav_lab/category_2/task_2_2.dart' as cat2_task2;
import 'package:nav_lab/category_2/task_2_3.dart' as cat2_task3;
import 'package:nav_lab/category_2/task_2_4.dart' as cat2_task4;
import 'package:nav_lab/category_2/task_2_5.dart' as cat2_task5;

import 'package:nav_lab/category_3/task_3_1.dart' as cat3_task1;
import 'package:nav_lab/category_3/task_3_2.dart' as cat3_task2;
import 'package:nav_lab/category_3/task_3_3.dart' as cat3_task3;
import 'package:nav_lab/category_3/task_3_4.dart' as cat3_task4;
import 'package:nav_lab/category_3/task_3_5.dart' as cat3_task5;

import 'package:nav_lab/category_4/task_4_1.dart' as cat4_task1;
import 'package:nav_lab/category_4/task_4_2.dart' as cat4_task2;
import 'package:nav_lab/category_4/task_4_3.dart' as cat4_task3;
import 'package:nav_lab/category_4/task_4_4.dart' as cat4_task4;
import 'package:nav_lab/category_4/task_4_5.dart' as cat4_task5;

import 'package:nav_lab/category_5/task_5_1.dart' as cat5_task1;
import 'package:nav_lab/category_5/task_5_2.dart' as cat5_task2;
import 'package:nav_lab/category_5/task_5_3.dart' as cat5_task3;
import 'package:nav_lab/category_5/task_5_4.dart' as cat5_task4;
import 'package:nav_lab/category_5/task_5_5.dart' as cat5_task5;

import 'package:nav_lab/category_6/task_6_1.dart' as cat6_task1;
import 'package:nav_lab/category_6/task_6_2.dart' as cat6_task2;
import 'package:nav_lab/category_6/task_6_3.dart' as cat6_task3;
import 'package:nav_lab/category_6/task_6_4.dart' as cat6_task4;
import 'package:nav_lab/category_6/task_6_5.dart' as cat6_task5;
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: cat1_task1.HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}