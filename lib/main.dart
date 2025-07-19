import 'package:flutter/material.dart';

void main() {
  runApp(const ShoppingBillApp());
}

class ShoppingBillApp extends StatelessWidget {
  const ShoppingBillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Bill App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Shopping Bill App')),
        body: const Center(child: Text('Welcome to Shopping Bill App')),
      ),
    );
  }
}
