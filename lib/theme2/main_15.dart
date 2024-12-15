import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'IndieFlower',
      ),
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Flutter App'),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage('assets/images/bg.jpg'),
            ),
            Image.asset('assets/icons/icon.png'),
            Positioned(
              top: 30,
              left: 115,
              child: Text(
                'My custom font',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  //fontFamily: 'IndieFlower'
                ),
              ),
            )
          ],
        ),
      ),
    )),
  );
}
