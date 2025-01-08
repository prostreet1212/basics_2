import 'package:basics_2/theme11/screens/location_screen.dart';
import 'package:basics_2/theme11/screens/weather_forecast_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(
       useMaterial3: false,
     ),
      home: LocationScreen(),
    );
  }
}