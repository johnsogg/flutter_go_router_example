import 'package:flutter/material.dart';
import 'package:navigate/controllers/navigation.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  final int activeButtonIndex;

  const BottomNav({super.key, required this.activeButtonIndex});

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    return BottomNavigationBar(
      currentIndex: activeButtonIndex,
      onTap: (idx) {
        switch (idx) {
          case 0:
            navigation.changeScreen('/');
            break;
          case 1:
            navigation.changeScreen('/settings');
            break;
          case 2:
            navigation.changeScreen('/about');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
        // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      ],
    );
  }
}
