import 'package:flutter/material.dart';
import './Screens/home_screen.dart';
import './Screens/weather_display_screen.dart';
import './Screens/settings_screen.dart';
void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/weather': (context) => WeatherDisplayScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
