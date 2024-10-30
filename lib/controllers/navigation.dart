import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  var screenName = '/';

  void changeScreen(String newScreenName) {
    screenName = newScreenName;
    notifyListeners();
  }
}
