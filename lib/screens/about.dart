import 'package:flutter/material.dart';
import 'package:navigate/components/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Screen")),
      bottomNavigationBar: const BottomNav(
        activeButtonIndex: 2,
      ),
    );
  }
}
