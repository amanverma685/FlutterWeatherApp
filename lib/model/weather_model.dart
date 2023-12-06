// lib/models/weather_model.dart
import 'dart:ffi';

class WeatherModel {
  final String city;
  final int temperature;
  final String condition;
  final String weather_icon;

  WeatherModel(
      {required this.city, required this.temperature, required this.condition, required this.weather_icon});

}
