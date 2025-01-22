import 'package:flutter/material.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        useMaterial3: false,
      )
      //home: HomePage(title: 'Rick and Morty'),
    );
  }
}
