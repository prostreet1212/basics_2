import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
        bodySmall: TextStyle(),
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
      ).apply(bodyColor: Colors.white)),
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 119, 138, 206),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 62, 85, 189),
            title: Text(
              'Counter',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body:    Align(
            alignment: Alignment.topCenter,
            child: Text('aaa'),),
        /*Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap \"-\" to decrement'),
                SizedBox(height: 8,),
                CounterWidget(),
                SizedBox(height: 8,),
                Text('Tap \"+\" to increment'),
              ],
            ),
          ),*/
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count=50;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          IconButton(
            onPressed: () {
              setState(() {
                _count-=1;
              });
            },
            icon: Icon(Icons.remove,size: 30,),
          ),
          Text('${_count}',style: TextStyle(color: Colors.grey[800],fontSize: 24),),
          IconButton(
            onPressed: () {
              setState(() {
                _count+=1;
              });
            },
            icon: Icon(Icons.add,size: 30,),
          ),
        ],
      ),
    );
  }
}
