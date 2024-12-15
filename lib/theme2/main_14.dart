import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyFirstApp());

class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<MyFirstApp> {
  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text('My first App'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: _loading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        value: _progressValue,
                        color: Colors.green,
                      ),
                      Text(
                        '${(_progressValue * 100).round()}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Press button to download',
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cloud_download),
          onPressed: () {
          setState(() {
            _loading=!_loading;
            _upddateProgress();
            return;
          });
          },
        ),
      ),
    );
  }

  void _upddateProgress(){
    const onSec= Duration(seconds: 1);
    Timer.periodic(onSec, (Timer t){
      setState(() {
        _progressValue+=0.2;
        if(_progressValue.toStringAsFixed(1)=='1.0'){
          _loading=false;
          t.cancel();
          _progressValue=0;
        }
      });
    });
  }
}
