import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final String city;

  const User({
    required this.name,
    required this.age,
    required this.city,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<User> _users = const [
    User(name: 'Sarah Connor', age: 29, city: 'Los Angeles'),
    User(name: 'John Doe', age: 34, city: 'New York'),
    User(name: 'Bruce Wayne', age: 40, city: 'Gotham'),
    User(name: 'Clark Kent', age: 33, city: 'Metropolis'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4.3: User List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user.name[0])),
            title: Text(user.name),
            subtitle: Text('${user.age} yrs • ${user.city}'),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}\'s Profile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(user.name[0], style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 30),
                ListTile(
                  leading: const Icon(Icons.cake, color: Colors.indigo),
                  title: const Text('Age'),
                  subtitle: Text('${user.age} years old'),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.indigo),
                  title: const Text('City'),
                  subtitle: Text(user.city),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}