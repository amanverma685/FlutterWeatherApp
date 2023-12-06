// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> getWeather(String city) async {
    final response =
        await http.get(Uri.parse('http://api.weatherstack.com/current?access_key=50ac4c7ce7404bdc69115ac4214a70eb&query='+city));
        print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
