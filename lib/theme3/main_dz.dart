import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 67, 54),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 244, 67, 54),
          title: Text(
            'Weather Forecast111',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return /*SingleChildScrollView(
      child:*/
      Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: InputBorder.none,
            labelText: 'Enter city name',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _cityDetail(),
        SizedBox(
          height: 40,
        ),
        _temperatureDetail(),
        SizedBox(
          height: 40,
        ),
        _extraWeatherDetail(),
        SizedBox(
          height: 40,
        ),
        Text(
          '7-DAY WEATHER FORECAST',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _weekWeatherForecast(),
      ],
    ),
  ); /*,
  );*/
}

Widget _cityDetail() {
  return Column(
    children: [
      Text(
        'Murmansk Oblast, RU',
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        'Friday, Mar 20, 2020',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ],
  );
}

Widget _temperatureDetail() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.sunny,
        size: 70,
        color: Colors.white,
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '14 °F',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          Text(
            'LIGHT SNOW',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      )
    ],
  );
}

Widget _extraWeatherDetail() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Icon(
            Icons.ac_unit,
            color: Colors.white,
          ),
          Text(
            '5',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'km/hr',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      Column(
        children: [
          Icon(
            Icons.ac_unit,
            color: Colors.white,
          ),
          Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '%',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      Column(
        children: [
          Icon(
            Icons.ac_unit,
            color: Colors.white,
          ),
          Text(
            '20',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '%',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ],
  );
}

Widget _weekWeatherForecast() {
  List<DayTemp> listDayTemp = [];

  listDayTemp.add(DayTemp('Monday', '22'));
  listDayTemp.add(DayTemp('Tuesday', '3'));
  listDayTemp.add(DayTemp('Wednesday', '5'));
  listDayTemp.add(DayTemp('Thursday', '23'));
  listDayTemp.add(DayTemp('Friday', '6'));
  listDayTemp.add(DayTemp('Saturday', '5'));
  listDayTemp.add(DayTemp('Sunday', '19'));
  return Container(
    height: 110,
    //width: MediaQuery.of(context).size.width,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: listDayTemp.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          //margin: EdgeInsets.symmetric(horizontal: 500),
          color: Colors.white30,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${listDayTemp[index].day}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'PlaywriteTZGuides',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${listDayTemp[index].temp} °F',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.sunny,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 10,
        );
      },
    ),
  );
}

class DayTemp {
  String day;
  String temp;

  DayTemp(this.day, this.temp);
}
