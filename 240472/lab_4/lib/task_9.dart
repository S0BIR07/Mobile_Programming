import 'package:flutter/material.dart';

class Task9Screen extends StatefulWidget {
  const Task9Screen({super.key});

  @override
  State<Task9Screen> createState() => _Task9ScreenState();
}

class _Task9ScreenState extends State<Task9Screen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task 9: Navigation'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_on), text: 'Top Tab 1'),
              Tab(icon: Icon(Icons.list), text: 'Top Tab 2'),
            ],
          ),
        ),
        body: IndexedStack(
          index: _bottomNavIndex,
          children: [
            const TabBarView(
              children: [
                Center(child: Text('Home Sub-view A')),
                Center(child: Text('Home Sub-view B')),
              ],
            ),
            const Center(child: Text('Search View')),
            const Center(child: Text('Profile View')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}