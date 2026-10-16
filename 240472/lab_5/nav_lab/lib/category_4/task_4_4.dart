import 'package:flutter/material.dart';
import 'task_4_3.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<User> _users = const [
    User(name: 'Alice Johnson', age: 26, city: 'Chicago'),
    User(name: 'Bob Miller', age: 31, city: 'Seattle'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4.4: onGenerateRoute'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user.name[0])),
            title: Text(user.name),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: user,
              );
            },
          );
        },
      ),
    );
  }
}

class ConstructorProfileScreen extends StatelessWidget {
  final User user;

  const ConstructorProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Age: ${user.age} | City: ${user.city}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}