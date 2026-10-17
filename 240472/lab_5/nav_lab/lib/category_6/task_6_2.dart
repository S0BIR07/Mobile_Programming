import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PathParamHomeScreen extends StatelessWidget {
  const PathParamHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path Parameters'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [1, 2, 3].map((id) {
            return ElevatedButton(
              onPressed: () => context.push('/product/$id'),
              child: Text('Product $id'),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProductIdScreen extends StatelessWidget {
  final String id;

  const ProductIdScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product #$id'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Displaying details for Product #$id',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

final pathParamRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PathParamHomeScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'Unknown';
        return ProductIdScreen(id: id);
      },
    ),
  ],
);