// lib/screens/weather_display_screen.dart
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<String> cities = [];

  _loadSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cities = prefs.getStringList('cities') ?? [];
    });
  }

  navigateToHomePage()async{
    Navigator.pushNamed(context, '/weather');
  }

  WeatherModel? _weather;
  @override
  void initState() {
    super.initState();
    _loadSelectedCity();
  }


  _addToFavourites()async{
    final city = _cityController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList('cities')??[];
    if (!(items.contains(city))) {
        items.add(city);
        await prefs.remove('cities');
        await prefs.setStringList('cities', items);
    }

  }
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

  void handleButtonClick(String city) async{
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
            const Text("Favourites"),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cities.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [

                          ElevatedButton(
                          onPressed: () {
                            handleButtonClick(cities[index]);
                          },
                          child:Text(cities[index]) ,
                        ),

                  ],
                );
              },
            ),
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
                      ElevatedButton(onPressed: _addToFavourites, child: const Text("Add to favourites"))
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}


