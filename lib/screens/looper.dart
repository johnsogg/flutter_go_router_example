import 'package:flutter/material.dart';

class LooperScreen extends StatelessWidget {
  const LooperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Looper Screen")),
        body: const Center(child: Text("Looper Screen")));
  }
}
