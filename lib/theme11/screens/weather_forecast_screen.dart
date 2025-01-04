import 'package:basics_2/theme11/api/weather_api.dart';
import 'package:basics_2/theme11/models/weather_forecast_daily.dart';
import 'package:flutter/material.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String _cityName='London';

  @override
  void initState() {
    super.initState();
    forecastObject=WeatherApi().fetchWeatherForecastWithCity(cityName: _cityName);
    forecastObject.then((weather){
      print(weather.list![0].weather[0].main);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather app'),),
      body: Container(),
    );
  }
}
