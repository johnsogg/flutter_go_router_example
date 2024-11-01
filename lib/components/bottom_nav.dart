import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // injects BuildContext.go method

class BottomNav extends StatelessWidget {
  final int activeButtonIndex;

  const BottomNav({super.key, required this.activeButtonIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeButtonIndex,
      onTap: (idx) {
        switch (idx) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/settings');
            break;
          case 2:
            context.go('/about');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
      ],
    );
  }
}
