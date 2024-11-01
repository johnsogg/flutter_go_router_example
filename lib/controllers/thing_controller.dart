import 'package:flutter/material.dart';
import 'package:navigate/models/thing.dart';

class ThingController extends ChangeNotifier {
  int thingIdx = 0;

  List<Thing> list = [
    Thing(name: 'Thing A', description: "The first thing"),
    Thing(name: 'Thing B', description: "The second thing"),
  ];

  void changeIndex(int newIdx) {
    thingIdx = newIdx;
    notifyListeners();
  }
}
