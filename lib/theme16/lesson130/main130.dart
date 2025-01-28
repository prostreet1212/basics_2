import 'package:basics_2/theme16/lesson130/global_key_example_one.dart';
import 'package:flutter/material.dart';

import 'global_key_example_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home:  const GlobalKeyExampleTwo(),
    );
  }
}