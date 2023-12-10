import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Screens/home_screen.dart';
import './Screens/weather_display_screen.dart';
import './Screens/home_page.dart';
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
        '/': (context) => const HomeScreen(),
        '/weather': (context) => const WeatherDisplayScreen(),
        '/get_city_weather': (context) =>  const HomePage(cityName: 'Delhi',),
      },
    );
  }
}
