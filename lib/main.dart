import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_app/discovery_screen.dart';
import 'package:flutter_bluetooth_app/home.dart';
import 'package:flutter_bluetooth_app/weather_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/weather': (context) => WeatherScreen(),
          '/discovery': (context) => DiscoveryPage(),
        },
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

enum TabItem {
  home,
  info,
}
