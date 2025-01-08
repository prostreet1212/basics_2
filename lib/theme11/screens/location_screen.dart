import 'dart:developer';

import 'package:basics_2/theme11/models/weather_forecast_daily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../api/weather_api.dart';
import 'weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationPermission permission;
  late bool serviceEnabled;
  void getLocationData() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print(serviceEnabled);
     /* if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }*/
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied||permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }else{
            WeatherForecast? weatherInfo = await WeatherApi().fetchWeatherForecast();
            if(weatherInfo==null){
              print('WeatherInfo was null: $weatherInfo');
              return;
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WeatherForecastScreen(locationWeather: weatherInfo,);
            }));
          }
        }else{
          WeatherForecast? weatherInfo = await WeatherApi().fetchWeatherForecast();
          if(weatherInfo==null){
            print('WeatherInfo was null: $weatherInfo');
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WeatherForecastScreen(locationWeather: weatherInfo,);
          }));
        }



    } catch (e) {
      // print('$e');
      log('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.black87, size: 100.0),
      ),
    );
  }
}