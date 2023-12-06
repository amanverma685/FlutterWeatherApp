// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Weather App')),
      body: Container(
            width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(

              image: AssetImage('./assets/bg.jpg'), // path to your background image
              fit: BoxFit.cover,
              // adjust the image fit
            ),
          ),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/weather');
                },
                child: const Text(' Check Weather '),
              ),],)


      ),
    );
  }
}
