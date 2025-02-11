import 'dart:convert';
import 'dart:developer';

import 'package:basics_2/theme11/models/weather_forecast_daily.dart';
import 'package:basics_2/theme11/utilities/constants.dart';
import 'package:basics_2/theme11/utilities/location.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      { String? cityName, bool? isCity}) async {
    Location location=Location();
    await location.getCurrentLocation();
    Map<String,String> parameters;
    if(isCity==true){
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName.toString(),
      };
      parameters=queryParameters;
    }else{
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
      parameters=queryParameters;
    }


    Uri uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parameters);
    log('request: ${uri.toString()}');

    var response=await http.get(uri);
    print('response: ${response.body}');
    if(response.statusCode==200){
      return WeatherForecast.fromJson(json.decode(response.body));
    }else{
      return Future.error('Error response');
    }
  }
}
