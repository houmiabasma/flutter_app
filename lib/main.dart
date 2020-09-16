import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_app/discovery_screen.dart';
import 'package:flutter_bluetooth_app/home.dart';
import 'package:flutter_bluetooth_app/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/discovery': (context) => DiscoveryPage(),
        '/weather': (context) => WeatherScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
