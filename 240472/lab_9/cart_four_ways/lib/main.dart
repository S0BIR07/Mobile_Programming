import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bloc/cart_page_bloc.dart';
import 'cubit/cart_page_cubit.dart';
import 'riverpod/cart_page_riverpod.dart';
import 'setstate/cart_page_setstate.dart';

void main() {
  runApp(const ProviderScope(child: CartApp()));
}

class CartApp extends StatelessWidget {
  const CartApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'One Cart, Four Ways',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('One Cart, Four Ways'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SetStateCartPage()),
                ),
                child: const Text('1. setState Cart'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RiverpodCartPage()),
                ),
                child: const Text('2. Riverpod Cart'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CubitCartPage()),
                ),
                child: const Text('3. Cubit Cart'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BlocCartPage()),
                ),
                child: const Text('4. Bloc Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}