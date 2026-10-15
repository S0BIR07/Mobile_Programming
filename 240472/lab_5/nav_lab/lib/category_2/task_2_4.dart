import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2.4: Drawer Navigation'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Home Screen Content\n(Swipe from left or tap menu icon to open drawer)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'App Navigation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _navigateTo(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => _navigateTo(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _navigateTo(context, '/settings'),
          ),
        ],
      ),
    );
  }
}

class DrawerProfileScreen extends StatelessWidget {
  const DrawerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen'), backgroundColor: Colors.teal),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Profile Screen Content')),
    );
  }
}

class DrawerSettingsScreen extends StatelessWidget {
  const DrawerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen'), backgroundColor: Colors.orange),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Settings Screen Content')),
    );
  }
}