import 'package:flutter/material.dart';

class SheetTransitionHomeScreen extends StatelessWidget {
  const SheetTransitionHomeScreen({super.key});

  void _openAsSheet(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SheetDetailsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;

          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );

          final offsetAnimation = Tween(begin: begin, end: end).animate(curvedAnimation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide From Bottom'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          onPressed: () => _openAsSheet(context),
          child: const Text('Open as a Sheet'),
        ),
      ),
    );
  }
}

class SheetDetailsScreen extends StatelessWidget {
  const SheetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheet Details'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close Sheet'),
        ),
      ),
    );
  }
}