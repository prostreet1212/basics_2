import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Flutter App'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Hellow Flutter',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
            textDirection: TextDirection.ltr,
          ),
        ),
      )
    ),
  );
}
