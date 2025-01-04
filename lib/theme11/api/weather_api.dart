import 'dart:convert';
import 'dart:developer';

import 'package:basics_2/theme11/models/weather_forecast_daily.dart';
import 'package:basics_2/theme11/utilities/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecastWithCity(
      {required String cityName}) async {
    var queryParameters = {
      'APPID': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': cityName,
    };
    Uri uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, queryParameters);
    log('request: ${uri.toString()}');

    var response=await http.get(uri);
    print('response: ${response.body}');
    if(response.statusCode==200){
      return WeatherForecast.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error response');
    }
  }
}
