import 'package:flutter/material.dart';
import 'package:navigate/models/thing.dart';

class ThingController extends ChangeNotifier {
  int thingIdx = 0;

  List<Thing> list = [
    Thing(name: 'Thing 1', description: "The first thing"),
    Thing(name: 'Thing 2', description: "The second thing"),
  ];

  void changeIndex(int newIdx) {
    thingIdx = newIdx;
    notifyListeners();
  }
}
