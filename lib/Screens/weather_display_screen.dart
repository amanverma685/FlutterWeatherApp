// lib/screens/weather_display_screen.dart
import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../Services/weather_service.dart';

class WeatherDisplayScreen extends StatefulWidget {
  const WeatherDisplayScreen({super.key});

  @override
  _WeatherDisplayScreenState createState() => _WeatherDisplayScreenState();
}

class _WeatherDisplayScreenState extends State<WeatherDisplayScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weather;

  void _fetchWeather() async {
    final city = _cityController.text;
    final weatherData = await _weatherService.getWeather(city);

    setState(() {

      _weather = WeatherModel(
        weather_icon:weatherData['current']['weather_icons'][0],
        city: weatherData['request']['query'],
        temperature: weatherData['current']['temperature'],
        condition: weatherData['current']['weather_descriptions'][0],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Display')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Enter City'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            _weather != null
                ? Column(
                    children: [
                      Text('City: ${_weather!.city}'),
                      Text('Temperature: ${_weather!.temperature}°C'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Aligns children to the center horizontally
                        children: [
                          Image.network(_weather!.weather_icon),
                          Text('  Condition: ${_weather!.condition}')],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
