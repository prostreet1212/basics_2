import 'package:basics_2/theme11/models/weather_forecast_daily.dart';
import 'package:flutter/material.dart';

import '../utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList=snapshot.data?.list;
    var city = snapshot.data?.city.name;
    var country = snapshot.data!.city.country;
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt*1000);
    return Container(
      child: Column(
        children: [
          Text(
            '$city, $country',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: Colors.black87,
            ),
          ),
          Text(
            Util.getFormattedDate(formattedDate),
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
