import 'package:flutter/material.dart';
import 'layers/pink_layer.dart';

class PinkTestPage extends StatelessWidget {
  const PinkTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pink Test')),
      body: const PinkLayer(),
    );
  }
}
