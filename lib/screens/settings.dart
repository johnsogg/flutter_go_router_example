import 'package:flutter/material.dart';
import 'package:navigate/components/bottom_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings Screen")),
      bottomNavigationBar: const BottomNav(
        activeButtonIndex: 1,
      ),
    );
  }
}
