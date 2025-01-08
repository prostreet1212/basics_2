import 'package:basics_2/theme11/api/weather_api.dart';
import 'package:basics_2/theme11/models/weather_forecast_daily.dart';
import 'package:basics_2/theme11/screens/city_screen.dart';
import 'package:basics_2/theme11/widgets/bottom_list_view.dart';
import 'package:basics_2/theme11/widgets/city_view.dart';
import 'package:basics_2/theme11/widgets/detail_view.dart';
import 'package:basics_2/theme11/widgets/temp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  const WeatherForecastScreen({super.key,required this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  late String _cityName;
  //late String _cityName;

  @override
  void initState() {
    super.initState();
    if(widget.locationWeather!=null){
      forecastObject =Future.value(widget.locationWeather);

    }

    // forecastObject.then((weather) {
    //   print(weather.list![0].weather[0].main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Text('Weather app'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.my_location),
            onPressed: (){
            setState(() {
              forecastObject=WeatherApi().fetchWeatherForecast();
            });
            },
            ),
        actions: [
          IconButton(
           icon: Icon(Icons.location_city),
          onPressed: ()async{
            String tappedName= await Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>CityScreen()));
             if(tappedName!=null){
               setState(() {
                 _cityName=tappedName;
                 forecastObject=WeatherApi().fetchWeatherForecast(cityName: _cityName,isCity: true);
               });
             }
          },)
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
                future: forecastObject,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                   return Column(

                     children: [
                       SizedBox(height: 50,),
                       CityView(snapshot: snapshot),
                       SizedBox(height: 50,),
                       TempView(snapshot: snapshot),
                       SizedBox(height: 50,),
                       DetailView(snapshot: snapshot),
                       SizedBox(height: 50,),
                       BottomListView(snapshot: snapshot),
                     ],
                   );
                  }else{
                    return Center(
                      child: Text('City not found\nPlease, enter correct city',
                      style: TextStyle(fontSize: 25),textAlign: TextAlign.center,)
                     /* child: SpinKitDoubleBounce(
                        color: Colors.black87,size: 100,
                      ),*/
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
