import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_app/discovery_screen.dart';
import 'package:flutter_bluetooth_app/home.dart';
import 'package:flutter_bluetooth_app/weather_screen.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/weather': (context) => WeatherScreen(),
        '/discovery': (context) => DiscoveryPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

enum TabItem {
  home,
  info,
}
