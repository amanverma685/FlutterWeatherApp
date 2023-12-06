import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import  'package:mp5/Screens/weather_display_screen.dart';
import 'package:mp5/Services/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  group('WeatherDisplayScreen Tests', () {
    late MockWeatherService mockWeatherService;
    late WeatherDisplayScreen weatherDisplayScreen;

    setUp(() {
      mockWeatherService = MockWeatherService();
      weatherDisplayScreen = WeatherDisplayScreen(weatherService: mockWeatherService);
    });

    testWidgets('Fetches weather data and updates UI', (WidgetTester tester) async {
      // Mock the behavior of the getWeather method
      when(mockWeatherService.getWeather(any)).thenAnswer(
            (_) async => {
          'request': {'query': 'Cupertino'},
          'current': {'temperature': 22, 'weather_icons': ['icon_url'], 'weather_descriptions': ['Sunny']}
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: weatherDisplayScreen,
        ),
      );

      // Ensure initial state
      expect(find.text('City:'), findsNothing);
      expect(find.text('Temperature:'), findsNothing);

      // Enter a city and tap the "Get Weather" button
      await tester.enterText(find.byType(TextField), 'Cupertino');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the UI updates with the fetched weather data
      expect(find.text('City: Cupertino'), findsOneWidget);
      expect(find.text('Temperature: 22°C'), findsOneWidget);
      expect(find.text('Condition: Sunny'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
