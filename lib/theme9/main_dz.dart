import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home:  const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
   const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
    create: (BuildContext context)=>DataProvider(),
    child: Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Consumer<DataProvider>(builder: (context,state,child){
        return AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            'Homework Provider',
            style: TextStyle(color: state.randColor),
          ),
          centerTitle: true,
        );
      })),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Consumer<DataProvider>(builder: (context,state,child){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                  width: 200,
                  height: 200,
                  color: state.randColor,
                  duration: const Duration(milliseconds: 800),
              curve: Curves.linear,),
              Switch(
                  value: state.isNotifiable, onChanged: (value) {
                state.toggleNotification(isNotifiable: value);
                state.changeColor();
              })
            ],
          );
        }),
      ),
    ),);
  }
}

class DataProvider extends ChangeNotifier{
  static bool _isNotifiable = false;
  static Color _randColor =Colors.green.shade400;

  bool get isNotifiable=>_isNotifiable;
  Color get randColor=>_randColor;




  void toggleNotification({required bool isNotifiable}) {
    _isNotifiable = isNotifiable;
    notifyListeners();
  }

  void changeColor(){
    _randColor = Color.fromRGBO(
      math.Random().nextInt(255),
      math.Random().nextInt(255),
      math.Random().nextInt(255),
      1,
    );
    notifyListeners();
  }
}
