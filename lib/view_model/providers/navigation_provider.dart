import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedBottomNavItem = 0;
  int get selectedBottomNavItem => _selectedBottomNavItem;

  updateSelectedNavItem(int newSelection) {
    _selectedBottomNavItem = newSelection;
    notifyListeners();
  }
}
