import 'dart:collection';

import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  ListQueue<int> navigationQueue=ListQueue();
  int selectedIndex=0;
  final GlobalKey<NavigatorState> bottomNavigatorKey=GlobalKey<NavigatorState>();
  final GlobalKey menuKey=GlobalKey();
  void bottomNavPop()
  {
    if(bottomNavigatorKey.currentState.canPop())
    {
      if (navigationQueue.isNotEmpty) {
        navigationQueue.removeLast();
        int position = navigationQueue.isEmpty
            ? 0
            : navigationQueue.last;
        bottomNavigatorKey.currentState.pop();
        update();
      }
    }
  }
  void changeBottomNavIndex(int index)
  {
    selectedIndex=index;
    update();
  }
}