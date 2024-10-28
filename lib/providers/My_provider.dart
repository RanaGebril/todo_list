import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode AppTheme = ThemeMode.light;

  // Constructor to load theme when provider is created
  MyProvider() {
    getTheme();
  }


  // Asynchronously loads the theme preference from SharedPreferences
  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? darkMode = prefs.getBool('isDark');
    if (darkMode != null) {
      AppTheme = darkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners(); // Notify listeners after setting the theme
    }
  }

  // This method changes the theme and stores the new preference in SharedPreferences
  Future<void> changeTheme(ThemeMode themeMode) async {
    AppTheme = themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', AppTheme == ThemeMode.dark);
    notifyListeners();
  }
}
